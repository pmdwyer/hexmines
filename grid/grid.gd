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
		for j in range(height):
			var t = _tile.instantiate()
			t.set_coords(i, j)
			_tiles.append(t)
			add_child(t)
	_setup_mines()


func _setup_mines():
	_num_mines = (width * height) / 10
	for i in range(_num_mines):
		var t = randi() % (width * height)
		_create_mine(t)


func _create_mine(i: int):
	_tiles[i].is_mine = true
	var neighbors = _get_neighbors(_tiles[i])
	for n in neighbors:
		n.num_neighbor_mines += 1


func _process(delta):
	var mouse_pos = get_viewport().get_mouse_position()
	var tile = _get_tile_at(mouse_pos)
	if tile:
		%is_mine_value.text = str(tile.is_mine)
		%num_mines_value.text = str(tile.num_neighbor_mines)


func _input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		var mouse_pos = get_viewport().get_mouse_position()
		var tile = _get_tile_at(mouse_pos)
		_flood_clear(tile)


func _flood_clear(start):
	var queue = [start]
	var seen = {}
	while len(queue) > 0:
		var tile = queue.pop_front()
		for n in _get_neighbors(tile):
			if n not in seen and not n.cleared and n.num_neighbor_mines == 0:
				queue.push_back(n)
		seen[tile] = true
		tile.clear()


func _get_tile_at(mouse_pos):
	for t in _tiles:
		if t.mouse_hit(mouse_pos):
			return t
	return null


func _get_neighbors(tile):
	var neighbors = []
	var neighbor_coords = tile.get_neighbor_coords()
	for nc in neighbor_coords:
		for t in _tiles:
			if t.coords == nc:
				neighbors.append(t)
	return neighbors
