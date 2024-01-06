extends Node2D


@export var width: int = 18
@export var height: int = 6


var _tile: PackedScene = preload("res://tile/tile.tscn")
var _num_mines: int = 0
var _tiles = []


func _ready():
	var random = RandomNumberGenerator.new()
	random.randomize()
	for i in range(width):
		_tiles.append([])
		for j in range(height):
			var t = _tile.instantiate()
			t.set_coords(i, j)
			_tiles[i].append(t)
			add_child(t)
	_setup_mines()


func _process(delta):
	var mouse_pos = get_viewport().get_mouse_position()


func _setup_mines():
	_num_mines = (width * height) / 10
	for i in range(_num_mines):
		var x = randi() % width
		var y = randi() % height
		_create_mine(x, y)


func _create_mine(x: int, y: int):
	_tiles[x][y].is_mine = true
	var neighbors = _tiles[x][y].get_neighbors()
	for n in neighbors:
		if n[0] >= 0 && n[0] < width && n[1] >= 0 && n[1] < height:
			_tiles[n[0]][n[1]].num_neighbor_mines += 1
