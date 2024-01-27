extends Control


signal start_game


func _ready():
	var viewport_rect = get_viewport_rect()
	var lsz = $Label.size
	var lp = Vector2(viewport_rect.size.x * .5, viewport_rect.size.y * .1)
	lp.x -= (lsz.x * 2)
	lp.y -= (lsz.y * 2)
	$Label.set_position(lp)
	var bp = Vector2(viewport_rect.size.x * .5, viewport_rect.size.y * .5)
	var bsz = $Button.size
	bp.x -= (bsz.x * 2)
	bp.y -= (bsz.y * 2)
	$Button.set_position(bp)


func _on_button_pressed():
	start_game.emit()
