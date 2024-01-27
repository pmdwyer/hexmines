extends Node2D


var grid_scene: PackedScene = preload("res://grid/grid.tscn")
var _grid
var _total_time: float = 0.0


signal game_over


func _ready():
	_create_grid()
	add_child(_grid)


func _process(delta):
	_total_time += delta
	%TimeLabel.text = "%.2f" % _total_time
	if _grid.game_over():
		var completed_time = ""
		if _grid.hit_mine:
			completed_time = "Lost game in:\t%.2f\n" % _total_time
		else:
			completed_time = "Won game in:\t%.2f\n" % _total_time
		%CompletedTimesList.append_text(completed_time)
		remove_child(_grid)
		_grid.queue_free()
		game_over.emit()


func _create_grid():
	_total_time = 0.0
	_grid = grid_scene.instantiate()
	_grid.width = 20
	_grid.height = 5
