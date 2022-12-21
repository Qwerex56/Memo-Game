extends KinematicBody2D
class_name Player

export(float) var move_speed : float = 50.0;
export(float) var friction : float = 0.15;
var velocity : Vector2 = Vector2.ZERO;
var direction : Vector2 = Vector2.ZERO;
var look_direction : Vector2 = Vector2.UP;

var colision : KinematicCollision2D = null;
var selected_tile : Tile = null;

func _physics_process(delta):
	direction = GetDirection();
	MovePlayer(delta);
	pass

func _unhandled_key_input(event):
	if event.is_action_pressed("open_tile", false):
		selected_tile.ShowTile();
	pass;

func MovePlayer(var dt : float) -> void:
	#warning-ignore:SHADOWED_VARIABLE
	var velocity : Vector2 = self.velocity;

	velocity.x = lerp(velocity.x, move_speed * direction.x, friction);
	velocity.y = lerp(velocity.y, move_speed * direction.y, friction);
	self.velocity = velocity;

	if (direction.y != 0):
		look_direction = Vector2(0, round(direction.y));
	elif (direction.x != 0):
		look_direction = Vector2(round(direction.x), 0);
		pass;
	
	$TileSelector.position = $Icon.texture.get_size() * look_direction;

	colision = move_and_collide(velocity * dt);
	pass;

func GetDirection() -> Vector2:
	var dir : Vector2 = direction;

	dir.x = Input.get_axis("move_left", "move_right");
	dir.y = Input.get_axis("move_up", "move_down")
	
	return dir.normalized();

func _on_TileSelector_area_entered(area:Area2D):
	if not area is Tile:
		return;

	selected_tile = area;
	pass;
