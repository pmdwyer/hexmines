extends Control


@export var game_scene: PackedScene = preload("res://game.tscn")


var _game


func _on_button_pressed():
	_game = game_scene.instantiate()
	_game.connect("game_over", _clean_up_game)
	add_child(_game)
	$Label.hide()
	$Button.hide()


func _clean_up_game():
	remove_child(_game)
	_game.queue_free()
	$Label.show()
	$Button.show()
