extends CharacterBody2D
class_name Paddle

var speed = 900.0
func _physics_process(_delta: float) -> void:
	var direction := Input.get_axis("paddle_left", "paddle_right")
	if direction:
		velocity.x = direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)

	move_and_slide()
