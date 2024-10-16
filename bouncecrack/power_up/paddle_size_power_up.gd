extends PowerUp
class_name PaddleSize


func _physics_process(delta: float) -> void:
	super._physics_process(delta) # Call parent class physics process

func _on_body_entered(body: Node2D) -> void:
	# From parent virtual function
	if body is Paddle:
		if body.paddle_width + 20.0 < 260.0:
			body.paddle_width += 20.0
		queue_free()
