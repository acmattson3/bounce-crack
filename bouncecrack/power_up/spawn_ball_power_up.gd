extends PowerUp
class_name SpawnBall

func _physics_process(delta: float) -> void:
	super._physics_process(delta) # Call parent class physics process

func _on_body_entered(body: Node2D) -> void:
	# From parent virtual function
	if body is Paddle:
		var paddle_position = body.global_position
		paddle_position.y -= 50 # Will want to spawn ball above paddle using its position
		EventHandler.create_ball.emit(paddle_position) # Spawn ball
		queue_free()
