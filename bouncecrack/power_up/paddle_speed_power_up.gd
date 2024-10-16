extends PowerUp
class_name PaddleSpeed


func _physics_process(delta: float) -> void:
	super._physics_process(delta) # Call parent class physics process

func _on_body_entered(body: Node2D) -> void:
	# From parent virtual function
	if body is Paddle:
		if (body.speed < 600):
			body.speed += 200
		queue_free()
