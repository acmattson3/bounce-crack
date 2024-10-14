@tool
extends CharacterBody2D
class_name Paddle

@export var paddle_width: float = 195.0:
	set(value):
		$CollisionShape2D.shape.size.x = value
		$TempPlayerPaddle.scale.x *= value / paddle_width
		paddle_width = value

var speed = 900.0
func _physics_process(delta: float) -> void:
	if Engine.is_editor_hint():
		return # Allows us to use @tool without breaking the editor
	var direction := Input.get_axis("paddle_left", "paddle_right")
	if direction:
		velocity.x = direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
	
	
	move_and_slide()
