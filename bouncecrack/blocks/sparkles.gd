extends Node2D

@export var sparkle_scene := load("res://blocks/sparkles.tscn")

var lifetime = 0.0;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	lifetime += delta
	if lifetime > 1.0:
		queue_free()
