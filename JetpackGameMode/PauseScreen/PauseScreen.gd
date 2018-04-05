extends Node2D

# class member variables go here, for example:
var resume_btn
var options_btn

var last_focus

var current_scene
var tutorial_screen
var options_path = "res://CommonScenes/OptionsMenu/OptionsMenuScreen.tscn"

func _ready():
	resume_btn = self.get_node("Resume")
	resume_btn.grab_focus()
	
	options_btn = self.get_node("Options")
	
	current_scene = get_tree().get_root().get_node("JetpackGame")
	tutorial_screen = current_scene.get_node("AboveScreen/TutorialScreen")
#	print(current_scene)
	
	set_process_input(true)
	pass

func _input(event):
	if event.is_action_pressed("pause") and not current_scene.game_over:
		if self.is_visible():
			resume_game()
		else:
			pause_game()
		pass

func pause_game():
	self.show()
	get_tree().set_pause(true)
	resume_btn.grab_focus()

func resume_game():
	self.hide()
	get_tree().set_pause(false)

func _on_resume_pressed():
	resume_game()

func _on_replay_pressed():
	if current_scene != null:
		get_tree().change_scene("res://JetpackGameMode/JetpackGame.tscn")
		resume_game()

func _on_quit_pressed():
	get_tree().quit()

func _on_tutorial_pressed():
	tutorial_screen.play()
	tutorial_screen.is_paused = true 


func _on_options_pressed():
	var path = options_path
	last_focus = options_btn.get_path()
	
	ScreenManager.load_above(path, last_focus, self)
