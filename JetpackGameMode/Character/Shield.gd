extends Area2D

# node variables
var player
var shield_animator
var shield_sprite

# member variables
var energy = 0

# "Stats" Limits?
const MAX_SHIELD = 3

func _ready():
	player = self.get_parent()
	shield_animator = self.get_node("ShieldAnimator")
	shield_sprite = self.get_node("Sprite")
	
	shield_animator.play("disabled")

func modulate_shield():
	var animation = shield_animator.get_current_animation()
	#print("MODULATE SHIELD | Energy:%s"%[energy])
	
	if energy == 0:
		shield_animator.play("disabled")
	elif energy == 1:
		shield_sprite.set_modulate(Color(0,0.96,1,1))
		shield_animator.play("open")
		yield(shield_animator,"finished")
		shield_animator.play("idle")
	elif energy == 2:
		shield_sprite.set_modulate(Color(0.6,0.27,1,1))
		if animation == "burst" or animation == "disabled":
			shield_animator.play("open")
			yield(shield_animator,"finished")
			shield_animator.play("idle")
	elif energy == 3:
		shield_sprite.set_modulate(Color(0.84,0,1,1))
		if animation == "burst" or animation == "disabled":
			shield_animator.play("open")
			yield(shield_animator,"finished")
			shield_animator.play("idle")
	else:
		print("SHIELD ERROR | UNKNOW VALUE OF ENERGY: %s"%[energy])
	
	player.shield_energy = energy

func increase_energy(increment):
	if energy+increment > MAX_SHIELD:
		energy = MAX_SHIELD
		player.score()
	elif energy+increment <= MAX_SHIELD:
		energy += increment
	else:
		print("SHIELD ERROR | UNKNOW VALUE OF INCREMENT: %s"%[increment])
	
	print("Shield Energy: %s | Incremet: %s"%[energy,increment])
	
	modulate_shield()

func decrease_energy(increment):
	if energy-increment < 0:
		energy = 0
	elif energy-increment >= 0:
		energy -= increment
	else:
		print("SHIELD ERROR | UNKNOW VALUE OF INCREMENT: %s"%[increment])
	
	shield_animator.play("burst")
	yield(shield_animator, "finished")
	modulate_shield()