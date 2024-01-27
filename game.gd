extends Node2D


var grid_scene: PackedScene = preload("res://grid/grid.tscn")
var _grid
var total_time: float = 0.0
var won = false


signal game_over


func _ready():
	_create_grid()
	add_child(_grid)


func _process(delta):
	total_time += delta
	%TimeLabel.text = "%.2f" % total_time
	if _grid.game_over():
		if not _grid.hit_mine:
			won = true
		var scores = get_node("/root/Scores")
		scores.all_scores.append([won, total_time])
		remove_child(_grid)
		_grid.queue_free()
		game_over.emit()


func _create_grid():
	total_time = 0.0
	_grid = grid_scene.instantiate()
	_grid.width = 20
	_grid.height = 5
