extends Position2D

export(NodePath) var obstacle_parent
export(NodePath) var obstacle_half_parent
export(PackedScene) var none
export(PackedScene) var pipe
export(PackedScene) var double_pipe
export(PackedScene) var triple_pipe
export(PackedScene) var wall
export(PackedScene) var laser_eye
export(PackedScene) var shield_up
export(PackedScene) var ammo_up

var obstacles = []

var obstacle_group
var half_group
var level
var half_countdown = 4

signal level_ready
signal level_end
signal update_visualization

func _ready():
	obstacle_group = get_node(obstacle_parent)
	half_group = get_node(obstacle_half_parent)
	obstacles = [
		none, #0
		pipe, #1
		double_pipe, #2
		triple_pipe, #3
		wall, #4
		laser_eye, #5
		shield_up, #6
		ammo_up #7
	]

func spawn(obstacle_num):
	var obstacle = obstacles[obstacle_num].instance()
	var position = self.get_global_pos()
	obstacle.set_pos(position)
	obstacle_group.add_child(obstacle)

func half_spawn(obstacle_num):
	var obstacle = obstacles[obstacle_num].instance()
	var position = self.get_global_pos()
	obstacle.set_pos(position)
	half_group.add_child(obstacle)

func next_beat():
	if level["beats"].size() > 0:
		spawn(level["beats"][0])
		level["beats"].pop_front()
		#print(level)
	else:
		emit_signal("level_end")
		pass

func next_half_beat():
	if level["half_beats"].size() > 0:
		half_spawn(level["half_beats"][0])
		level["half_beats"].pop_front()
		#print(level)


func set_level(level_dict):
	level = level_dict
	print(level)
	
	emit_signal("level_ready", level)
	next_beat()

func _on_Beat_area_exit( area ):
	if area.is_in_group("score") and not area.get_parent().get_parent() == half_group:
		next_beat()
		emit_signal("update_visualization")

func _on_HalfBeat_area_exit( area ):
	if area.is_in_group("score") and not area.get_parent().get_parent() == half_group:
		next_half_beat()
		emit_signal("update_visualization")

func connect_tutorial_signal(object):
	if not self.is_connected("update_visualization",object,"beat_countdown"):
		self.connect("update_visualization",object,"beat_countdown")
