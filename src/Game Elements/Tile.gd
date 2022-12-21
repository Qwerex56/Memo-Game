extends Area2D
class_name Tile

signal Show_Tile(tile)
signal Hide_Tile(tile)

enum State {
	hidden,
	shown
}

var state : int = State.hidden;

func _exit_tree():
	#play exit animation
	pass

func ShowTile():
	if (state != State.hidden):
		return
	#play animation
	state = State.shown;
	$FrontImage.visible = true
	$Background.visible = true
	$TileCover.visible = false
	emit_signal("Show_Tile", self)
	pass

func HideTile():
	if (state != State.shown):
		return
	#play animation
	state = State.hidden
	$FrontImage.visible = false
	$Background.visible = false
	$TileCover.visible = true
	emit_signal("Hide_Tile", self)
	pass

func DeleteTile():
	pass