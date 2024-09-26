extends CharacterBody2D
class_name Ball

var speed = 1200.0
var direction := Vector2.DOWN # Start by going straight down

func _physics_process(delta: float) -> void:
	velocity = direction * speed
	move_and_slide()

func _on_bottom_area_2d_body_entered(body: Node2D) -> void:
	if body is Paddle:
		direction = ($NewBounceComparePos.global_position - body.global_position).normalized()
	else:
		direction.y = -direction.y
func _on_top_area_2d_body_entered(body: Node2D) -> void:
	direction.y = -direction.y
func _on_right_area_2d_body_entered(body: Node2D) -> void:
	direction.x = -direction.x
func _on_left_area_2d_body_entered(body: Node2D) -> void:
	direction.x = -direction.x
