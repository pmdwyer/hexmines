extends Node2D


var grid_scene: PackedScene = preload("res://grid/grid.tscn")
var _grid


func _ready():
	_create_grid()
	add_child(_grid)


func _process(delta):
	if _grid.game_over():
		remove_child(_grid)
		_create_grid()
		add_child(_grid)


func _create_grid():
	_grid = grid_scene.instantiate()
	_grid.width = 20
	_grid.height = 5
