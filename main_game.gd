extends Node2D


var total_time: float = 0.0
var won = false
var mines = []
var neighbors = {}
var height = 18
var width = 6


signal game_over


func _ready():
	var random = RandomNumberGenerator.new()
	random.randomize()
	$background_grid.setup()
	$main_grid.setup()
	$highlight_grid.setup()
	_setup_tiles()
	_setup_mines()
	_init_tiles()


func _process(delta):
	total_time += delta
	%TimeLabel.text = "%.2f" % total_time


func add_score(won):
	var scores = get_node("/root/Scores")
	scores.all_scores.append([won, total_time, Time.get_datetime_string_from_system()])
	game_over.emit()


func _setup_tiles():
	for t in $main_grid.tiles:
		t.connect("hit_mine", _on_mine_hit.bind())
		neighbors[t] = _get_neighbors(t)


func _get_neighbors(tile):
	var neighbors = []
	var neighbor_coords = tile.get_neighbor_coords()
	for nc in neighbor_coords:
		for t in $main_grid.tiles:
			if t.coords == nc:
				neighbors.append(t)
	return neighbors


func _setup_mines():
	var num_mines = (width * height) / 5
	for i in range(num_mines):
		var t = randi() % (width * height)
		while $main_grid.tiles[t].is_mine:
			t = randi() % (width * height)
		$main_grid.tiles[t].is_mine = true
		for n in neighbors[$main_grid.tiles[t]]:
			n.num_neighbor_mines += 1
		mines.append($main_grid.tiles[t])


func _init_tiles():
	for t in $main_grid.tiles:
		t.init()


func _on_mine_hit():
	game_over.emit()
