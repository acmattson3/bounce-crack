extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_despawn_timer_timeout() -> void:
	queue_free()
	print("Block has despawned")


func _on_area_2d_body_exited(_body: Node2D) -> void:
	print("Ball has left area, started  timer")
	$DespawnTimer.start()
