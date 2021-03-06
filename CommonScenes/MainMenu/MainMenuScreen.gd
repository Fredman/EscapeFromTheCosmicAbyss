extends Node2D

#Menu Paths
export(String, FILE) var options_path = "res://CommonScenes/OptionsMenu/OptionsMenuScreen.tscn"
export(String, FILE) var game_path

var continue_btn
var new_game_btn
var arcade_btn
var speedrun_btn
var cat15_btn
var cat30_btn
var cat40_btn
var catU_btn
var back_btn
var options_btn
var quit_btn

var game_mode = "story"
var last_focus

func _ready():
	continue_btn = get_node("MenuContainer/Continue")
	new_game_btn = get_node("MenuContainer/NewGame")
	arcade_btn = get_node("MenuContainer/ArcadeMode")
	speedrun_btn = get_node("MenuContainer/SpeedrunMode")
	cat15_btn = get_node("MenuContainer/Category15")
	cat30_btn = get_node("MenuContainer/Category30")
	cat40_btn = get_node("MenuContainer/Category40")
	catU_btn = get_node("MenuContainer/Unlimited")
	back_btn = get_node("MenuContainer/Back")
	options_btn = get_node("MenuContainer/Options")
	quit_btn = get_node("MenuContainer/QuitGame")
	
	toggle_menuitems(game_mode)

func _on_options_pressed():
	var path = options_path
	last_focus = options_btn
	
	ScreenManager.load_above(path, last_focus, self)

func _on_quit_pressed():
	get_tree().quit()

func _on_Continue_pressed():
	Global.set_game_mode("story", "select level")
	ScreenManager.load_screen(game_path)

func _on_NewGame_pressed():
	Global.reset_story_progress()
	if Global.is_tutorial_completed():
		Global.set_game_mode("story", "select level")
	else:
		Global.set_game_mode("story", "level selected")
	
	#TO DO - Load Intro instead of game.
	ScreenManager.load_screen(game_path)


func _on_ArcadeMode_pressed():
	game_mode = "arcade"
	toggle_menuitems(game_mode)

func _on_SpeedrunMode_pressed():
	game_mode = "speedrun"
	toggle_menuitems(game_mode)

func _on_Back_pressed():
	game_mode = "story"
	toggle_menuitems(game_mode)

func toggle_menuitems(game_mode):
	if game_mode == "story":
		if Global.is_story_completed():
			arcade_btn.set_disabled(false)
			speedrun_btn.set_disabled(false)
		else:
			arcade_btn.set_disabled(true)
			speedrun_btn.set_disabled(true)
		
		new_game_btn.show()
		arcade_btn.show()
		speedrun_btn.show()
		options_btn.show()
		quit_btn.show()
		
		if Global.is_tutorial_completed():
			continue_btn.show()
			continue_btn.grab_focus()
			
			continue_btn.set_focus_neighbour(MARGIN_TOP, quit_btn.get_path())
			quit_btn.set_focus_neighbour(MARGIN_BOTTOM, continue_btn.get_path())
		else:
			continue_btn.hide()
			new_game_btn.grab_focus()
			
			new_game_btn.set_focus_neighbour(MARGIN_TOP, quit_btn.get_path())
			quit_btn.set_focus_neighbour(MARGIN_BOTTOM, new_game_btn.get_path())
		
		arcade_btn.set_focus_neighbour(MARGIN_TOP, "")
		speedrun_btn.set_focus_neighbour(MARGIN_TOP, "")
		
		cat15_btn.hide()
		cat30_btn.hide()
		cat40_btn.hide()
		catU_btn.hide()
		back_btn.hide()
	elif game_mode == "arcade" or game_mode == "speedrun":
		if game_mode == "arcade":
			arcade_btn.show()
			speedrun_btn.hide()
			
			arcade_btn.set_focus_neighbour(MARGIN_TOP, back_btn.get_path())
			back_btn.set_focus_neighbour(MARGIN_BOTTOM, arcade_btn.get_path())
		else:
			arcade_btn.hide()
			speedrun_btn.show()
			
			speedrun_btn.set_focus_neighbour(MARGIN_TOP, back_btn.get_path())
			back_btn.set_focus_neighbour(MARGIN_BOTTOM, speedrun_btn.get_path())
		
		continue_btn.hide()
		new_game_btn.hide()
		options_btn.hide()
		quit_btn.hide()
		cat15_btn.show()
		cat30_btn.show()
		cat40_btn.show()
		catU_btn.show()
		back_btn.show()



func _on_Category_pressed(upgrade_point):
	var game_settings = {
			"game mode": game_mode, 
			"sub-mode": String(upgrade_point)
	}
	Global.reset_category_progress(game_settings)
	Global.set_game_mode(game_mode, String(upgrade_point))
	ScreenManager.load_screen(game_path)
