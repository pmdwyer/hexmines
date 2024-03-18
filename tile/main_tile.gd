extends Tile


@export var is_mine: bool = false
@export var num_neighbor_mines: int = 0
@export var is_flagged: bool = false
@export var cleared: bool = false


signal hit_mine
signal tile_flag(flagged)


func init():
	if num_neighbor_mines > 0:
		%NumMinesLabel.text = str(num_neighbor_mines)


func mouse_hit(mouse_pos: Vector2) -> bool:
	if %HexSprite:
		return %HexSprite.get_rect().has_point(to_local(mouse_pos))
	return false


func mouse_left_click():
	if is_mine:
		hit_mine.emit()
	if not cleared:
		cleared = true
		%HexSprite.hide()


func mouse_right_click():
	is_flagged = not is_flagged
	tile_flag.emit(is_flagged)
	if is_flagged:
		%FlagSprite.show()
	else:
		%FlagSprite.hide()
