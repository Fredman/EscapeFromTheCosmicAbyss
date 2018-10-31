extends Node

var level_title = "Level 01"
var intro_beats = [1,1,1,1,1]
var intro_halfs = [0,0,0,0,0]
var end_beat = 4
var boss = {
	"boss_level": false,
	"laser_countdown":0,
	"scream": false,
	"countdown": 0,
	"sequence": []
}

var beats = {
	"none": 0,
	"tentacles": 5,
	"double_pipe":1,
	"triple_pipe":1,
	"wall": 1,
	"laser_eye": 0,
	"shield_up": 0,
	"ammo_up": 0
}

var half_beats = {
	"none": 5,
	"tentacles": 1,
	"double_pipe":1,
	"triple_pipe":1,
	"wall": 0,
	"laser_eye": 0,
	"shield_up": 0,
	"ammo_up": 0
}