extends Node2D

@export var sparkle_scene := load("res://blocks/sparkles.tscn")

var lifetime = 0.0;

func _ready() -> void:
	$GPUParticles2D.emitting = true

func _process(delta: float) -> void:
	lifetime += delta
	if lifetime > 1.0:
		queue_free()
