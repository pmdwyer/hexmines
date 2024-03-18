extends Node2D


var total_time: float = 0.0
var won = false
var mines = []
var neighbors = {}


signal game_over


func _ready():
	var random = RandomNumberGenerator.new()
	random.randomize()
	$background_grid.setup()
	$main_grid.setup()
	$highlight_grid.setup()


func _process(delta):
	total_time += delta
	%TimeLabel.text = "%.2f" % total_time


func add_score(won):
	var scores = get_node("/root/Scores")
	scores.all_scores.append([won, total_time, Time.get_datetime_string_from_system()])
	game_over.emit()


#func _setup_mines():
	#_num_mines = (width * height) / 5
	#for i in range(_num_mines):
		#var t = randi() % (width * height)
		#while _tiles[t].is_mine:
			#t = randi() % (width * height)
		#_create_mine(t)
#
#
#func _create_mine(i: int):

	#_mines.append(_tiles[i])
	#var neighbors = _get_neighbors(_tiles[i])
	#for n in neighbors:
		#n.add_mine()
