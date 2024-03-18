extends Node2D

@export var main_menu_scene: PackedScene = preload("res://main_menu.tscn")
@export var game_scene: PackedScene = preload("res://main_game.tscn")
@export var score_scene: PackedScene = preload("res://score_screen.tscn")

var _menu
var _game
var _score


func _ready():
	_main_menu()


func _start_game():
	_game = game_scene.instantiate()
	_game.connect("game_over", _game_over)
	remove_child(_menu)
	_menu.queue_free()
	add_child(_game)


func _main_menu():
	_menu = main_menu_scene.instantiate()
	get_viewport_transform()
	_menu.connect("start_game", _start_game)
	_menu.connect("score_screen", _score_screen)
	add_child(_menu)


func _game_over():
	remove_child(_game)
	_game.queue_free()
	_score_screen()


func _score_screen():
	if _menu != null:
		remove_child(_menu)
		_menu.queue_free()
	_score = score_scene.instantiate()
	_score.connect("score_over", _restart)
	add_child(_score)


func _restart():
	remove_child(_score)
	_score.queue_free()
	_main_menu()
