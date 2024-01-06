extends Node2D


@export var is_mine: bool = false
@export var num_neighbor_mines: int = 0
@export var is_flagged: bool = false;


var _global_x: int = 0
var _global_y: int = 0
var _i: int = 0
var _j: int = 0
var _size


func set_coords(i: int, j: int):
	_i = i
	_j = j
	# TODO clean up magic numbers
	_global_x = (_i * 32) + 64
	_global_y = (_j * 96) + 64
	if (_i % 2) == 1:
		_global_y += 48
	position = Vector2i(_global_x, _global_y)


func mouse_hit(mouse_pos: Vector2) -> bool:
	return $Sprite2D.get_rect().has_point(to_local(mouse_pos))


func get_neighbors():
	var neighbors = [[_i - 2, _j], [_i + 2, _j], [_i - 1, _j], [_i + 1, _j]]
	if _i % 2 == 0:
		neighbors.append([_i - 1, _j - 1])
		neighbors.append([_i + 1, _j - 1])
	else:
		neighbors.append([_i - 1, _j + 1])
		neighbors.append([_i + 1, _j + 1])
	return neighbors



