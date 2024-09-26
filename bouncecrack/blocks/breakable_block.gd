extends Node2D
class_name BreakableBlock


func _on_area_2d_area_exited(area: Area2D) -> void:
	queue_free()
