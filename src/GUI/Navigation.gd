extends Control
class_name Navigation_GUI

signal PauseGame()
signal ResetGrid()

export var arrow_up : NodePath
export var arrow_down : NodePath
export var arrow_left : NodePath
export var arrow_right : NodePath
export var pause_button : NodePath
export var restart_button : NodePath

export var glow_color : Color = Color.white

export var main_scene : NodePath

func _unhandled_key_input(event):
	if event.is_action_pressed("ui_pause", false):
		emit_signal("PauseGame")
	if event.is_action_pressed("ui_reset_game", false):
		emit_signal("ResetGrid")
	pass

func _process(_delta):
	if Input.is_action_pressed("move_up"):
		GlowUpArrow(get_node(arrow_up), glow_color)
	if Input.is_action_pressed("move_down"):
		GlowUpArrow(get_node(arrow_down), glow_color)
	if Input.is_action_pressed("move_left"):
		GlowUpArrow(get_node(arrow_left), glow_color)
	if Input.is_action_pressed("move_right"):
		GlowUpArrow(get_node(arrow_right), glow_color);
	if Input.is_action_pressed("ui_pause"):
		GlowUpArrow(get_node(pause_button), glow_color);
	if Input.is_action_pressed("ui_reset_game"):
		GlowUpArrow(get_node(restart_button), glow_color);

	if Input.is_action_just_released("move_up"):
		GlowUpArrow(get_node(arrow_up), Color.white)
	if Input.is_action_just_released("move_down"):
		GlowUpArrow(get_node(arrow_down), Color.white)
	if Input.is_action_just_released("move_left"):
		GlowUpArrow(get_node(arrow_left), Color.white)
	if Input.is_action_just_released("move_right"):
		GlowUpArrow(get_node(arrow_right), Color.white);
	if Input.is_action_just_released("ui_pause"):
		GlowUpArrow(get_node(pause_button), Color.white)
	if Input.is_action_just_released("ui_reset_game"):
		GlowUpArrow(get_node(restart_button), Color.white)
	pass

func GlowUpArrow(arr : TextureRect, col : Color):
	arr.modulate = col
	pass
