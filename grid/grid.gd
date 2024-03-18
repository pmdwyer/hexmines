class_name Grid extends Node2D


@export var width: int = 18
@export var height: int = 6
@export var tile_type: PackedScene
@export var enable_click: bool = false
@export var enable_hover: bool = false


var _tiles = []
var hover_tile: Tile = null


func setup():
	for i in range(width):
		for j in range(height):
			var tile = tile_type.instantiate() as Tile
			tile.set_coords(i, j)
			_tiles.append(tile)
			add_child(tile)


func _input(event):
	if enable_hover and (event is InputEventMouse):
		if hover_tile:
			hover_tile.mouse_exit()
		hover_tile = _get_tile_at_mouse()
		if hover_tile:
			hover_tile.mouse_enter()

	if not enable_click:
		return
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		var tile = _get_tile_at_mouse()
		if tile:
			tile.mouse_left_click()
	elif event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_RIGHT and event.pressed:
		var tile = _get_tile_at_mouse()
		if tile:
			tile.mouse_right_click()


func _get_tile_at_mouse() -> Tile:
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
