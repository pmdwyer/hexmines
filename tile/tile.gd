class_name Tile extends Node2D


@export var coords: Vector2i
var _global_x: int = 0
var _global_y: int = 0


func set_coords(i: int, j: int):
	coords = Vector2i(i, j)
	# TODO clean up magic numbers
	_global_x = (coords.x * 32) + 64
	_global_y = (coords.y * 96) + 64
	if (coords.x % 2) == 1:
		_global_y += 48
	position = Vector2i(_global_x, _global_y)


func get_neighbor_coords():
	var neighbors = [
		Vector2i(coords.x - 2, coords.y),
		Vector2i(coords.x + 2, coords.y),
		Vector2i(coords.x - 1, coords.y),
		Vector2i(coords.x + 1, coords.y)
	]
	if coords.x % 2 == 0:
		neighbors.append(Vector2i(coords.x - 1, coords.y - 1))
		neighbors.append(Vector2i(coords.x + 1, coords.y - 1))
	else:
		neighbors.append(Vector2i(coords.x - 1, coords.y + 1))
		neighbors.append(Vector2i(coords.x + 1, coords.y + 1))
	return neighbors


func mouse_hit(mouse_pos: Vector2) -> bool:
	return false


func mouse_right_click() -> void:
	pass


func mouse_left_click() -> void:
	pass


func mouse_enter() -> void:
	pass


func mouse_exit() -> void:
	pass
