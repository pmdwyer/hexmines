extends Control


signal start_game
signal score_screen


func _ready():
	var viewport_rect = get_viewport_rect()
	var lsz = $Label.size
	var lp = Vector2(viewport_rect.size.x * .5, viewport_rect.size.y * .1)
	lp.x -= (lsz.x * 2)
	lp.y -= (lsz.y * 2)
	$Label.set_position(lp)
	var ngb = Vector2(viewport_rect.size.x * .5, viewport_rect.size.y * .3)
	var ngbsz = %NewGameButton.size
	ngb.x -= (ngbsz.x * 2)
	ngb.y -= (ngbsz.y * 2)
	%NewGameButton.set_position(ngb)
	var bp = Vector2(viewport_rect.size.x * .5, viewport_rect.size.y * .5)
	var bsz = %HighScoreButton.size
	bp.x -= (bsz.x * 2)
	bp.y -= (bsz.y * 2)
	%HighScoreButton.set_position(bp)


func _on_button_pressed():
	start_game.emit()


func _on_high_score_button_pressed():
	score_screen.emit()
