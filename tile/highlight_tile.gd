extends Tile


func mouse_hit(mouse_pos: Vector2) -> bool:
	if $Sprite2D:
		return $Sprite2D.get_rect().has_point(to_local(mouse_pos))
	return false


func mouse_enter() -> void:
	$Sprite2D.show()


func mouse_exit() -> void:
	$Sprite2D.hide()
