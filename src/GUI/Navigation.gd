extends Control
class_name Navigation_GUI

export var arrow_up : NodePath
export var arrow_down : NodePath
export var arrow_left : NodePath
export var arrow_right : NodePath

export var glow_color : Color = Color.white

func _process(_delta):
	if Input.is_action_pressed("move_up"):
		GlowUpArrow(get_node(arrow_up), glow_color)
	if Input.is_action_pressed("move_down"):
		GlowUpArrow(get_node(arrow_down), glow_color)
	if Input.is_action_pressed("move_left"):
		GlowUpArrow(get_node(arrow_left), glow_color)
	if Input.is_action_pressed("move_right"):
		GlowUpArrow(get_node(arrow_right), glow_color);

	if Input.is_action_just_released("move_up"):
		GlowUpArrow(get_node(arrow_up), Color.white)
	if Input.is_action_just_released("move_down"):
		GlowUpArrow(get_node(arrow_down), Color.white)
	if Input.is_action_just_released("move_left"):
		GlowUpArrow(get_node(arrow_left), Color.white)
	if Input.is_action_just_released("move_right"):
		GlowUpArrow(get_node(arrow_right), Color.white);
	pass

func GlowUpArrow(arr : TextureRect, col : Color):
	arr.modulate = col
	pass

func _on_Pause_Button_pressed():
	print("pause")
	pass # Replace with function body.
