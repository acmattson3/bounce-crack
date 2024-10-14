extends Area2D
class_name PowerUp

var out_of_bounds : bool = false
@export var speed: float = 700.0

func _physics_process(delta: float) -> void:
	position.y += speed * delta # Fall speed pixels/second
	
	if global_position.y >= 1000.0 and not out_of_bounds:
		out_of_bounds = true
		queue_free()

func _on_body_entered(_body: Node2D) -> void:
	pass # Virtual function
