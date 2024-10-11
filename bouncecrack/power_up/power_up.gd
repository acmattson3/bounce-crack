extends Area2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

var out_of_bounds : bool = false;

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.y += 500.0 * delta
	
	if global_position.y >= 1000.0 and not out_of_bounds:
		out_of_bounds = true
		queue_free()


func _on_body_entered(body: Node2D) -> void:
	if body is Paddle:
		queue_free()
