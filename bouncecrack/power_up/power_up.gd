extends Area2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

var out_of_bounds : bool = false;

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.y += 700.0 * delta
	
	if global_position.y >= 1000.0 and not out_of_bounds:
		out_of_bounds = true
		queue_free()


func _on_body_entered(body: Node2D) -> void:
	if body is Paddle:
		var paddle_position = body.global_position
		paddle_position.y -= 50 # Will want to spawn ball above paddle using its position
		EventHandler.create_ball.emit(paddle_position) # Spawn ball
		queue_free()
