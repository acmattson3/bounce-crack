extends CharacterBody2D
class_name Ball

var speed = 1200.0
var direction := Vector2.DOWN # Start by going straight down

var out_of_bounds: bool = false

func _physics_process(_delta: float) -> void:
	if global_position.y >= 1000.0 and not out_of_bounds:
		out_of_bounds = true
		EventHandler.total_balls -= 1
		queue_free()
	
	velocity = direction * speed
	move_and_slide()

func _on_bottom_area_2d_body_entered(body: Node2D) -> void:
	if body is Paddle:
		direction = ($NewBounceComparePos.global_position - body.global_position).normalized()
	else:
		direction.y = -direction.y
	if body is BreakableBlock:
		body.break_block()
func _on_top_area_2d_body_entered(body: Node2D) -> void:
	direction.y = -direction.y
	if body is BreakableBlock:
		body.break_block()
func _on_right_area_2d_body_entered(body: Node2D) -> void:
	direction.x = -direction.x
	if body is BreakableBlock:
		body.break_block()
func _on_left_area_2d_body_entered(body: Node2D) -> void:
	direction.x = -direction.x
	if body is BreakableBlock:
		body.break_block()
