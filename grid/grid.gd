extends Node2D


@export var width: int = 18
@export var height: int = 6
var hit_mine: bool = false


var _tile: PackedScene = preload("res://tile/tile.tscn")
var _num_mines: int = 0
var _tiles = []
var _mines = []
var _selectedTile


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
		while _tiles[t].is_mine:
			t = randi() % (width * height)
		_create_mine(t)


func _create_mine(i: int):
	_tiles[i].is_mine = true
	_mines.append(_tiles[i])
	var neighbors = _get_neighbors(_tiles[i])
	for n in neighbors:
		n.add_mine()


func _input(event):
	var tile = _get_tile_at_mouse()
	if event is InputEventMouse:
		if tile:
			if _selectedTile:
				_selectedTile.unselect()
			_selectedTile = tile
			tile.select()
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		if tile:
			if not tile.is_mine:
				_flood_clear(tile)
			else:
				hit_mine = true
	elif event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_RIGHT and event.pressed:
		if tile and not tile.cleared:
			tile.toggle_flag()


func _flood_clear(start):
	var queue = [start]
	var seen = {}
	while len(queue) > 0:
		var tile = queue.pop_front()
		if tile.num_neighbor_mines == 0 and not tile.is_mine:
			for n in _get_neighbors(tile):
				if n not in seen and not n.cleared and not n.is_mine:
					queue.push_back(n)
		seen[tile] = true
		tile.clear()


func _get_tile_at_mouse():
	var mouse_pos = get_viewport().get_mouse_position()
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


func game_over() -> bool:
	return hit_mine or (_mines.all(func(m): return m.is_flagged) and _tiles.all(func(t): return t.is_mine or t.cleared))
