extends CharacterBody2D
class_name Ball

const max_speed = 4000.0
var speed = 1200.0:
	set(value):
		if value > max_speed:
			print("Speed to high! Maxed to ", max_speed)
			speed = max_speed
		elif value <= 0:
			print("Speed too low! Retaining old value.")
		else:
			speed = value
var direction := Vector2.DOWN # Start by going straight down

var out_of_bounds: bool = false

func _physics_process(_delta: float) -> void:
	if global_position.y >= 1000.0 and not out_of_bounds:
		out_of_bounds = true
		queue_free()
	
	velocity = direction * speed
	move_and_slide()

func _on_bottom_area_2d_body_entered(body: Node2D) -> void:
	if direction.y < 0:
		return
	if abs(direction.y) < 0.05:
		direction.x = -direction.x
	if body is Paddle:
		if global_position.y < body.global_position.y: # Balls below paddle do not collide
			direction = ($NewBounceComparePos.global_position - body.global_position).normalized()
	else:
		direction.y = -direction.y
	if body is BreakableBlock:
		body.break_block()
func _on_top_area_2d_body_entered(body: Node2D) -> void:
	if body is Paddle:
		return
	if direction.y > 0:
		return
	direction.y = -direction.y
	if body is BreakableBlock:
		body.break_block()
func _on_right_area_2d_body_entered(body: Node2D) -> void:
	if direction.x < 0:
		return
	direction.x = -direction.x
	if body is BreakableBlock:
		body.break_block()
func _on_left_area_2d_body_entered(body: Node2D) -> void:
	if direction.x > 0:
		return
	if abs(direction.x) < 0.05:
		direction.y = -direction.y
	direction.x = -direction.x
	if body is BreakableBlock:
		body.break_block()
