extends Node2D


@export var is_mine: bool = false
@export var num_neighbor_mines: int = 0
@export var is_flagged: bool = false
@export var coords: Vector2i
@export var cleared: bool = false


var _global_x: int = 0
var _global_y: int = 0
var _size


func set_coords(i: int, j: int):
	coords = Vector2i(i, j)
	# TODO clean up magic numbers
	_global_x = (coords.x * 32) + 64
	_global_y = (coords.y * 96) + 64
	if (coords.x % 2) == 1:
		_global_y += 48
	position = Vector2i(_global_x, _global_y)


func mouse_hit(mouse_pos: Vector2) -> bool:
	if $Sprite2D:
		return $Sprite2D.get_rect().has_point(to_local(mouse_pos))
	return false


func clear():
	if not cleared:
		cleared = true
		$Sprite2D.queue_free()
		remove_child($Sprite2D)


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



