extends Node2D
class_name BreakableBlock

var broken: bool = false

func break_block():
	if not broken:
		EventHandler.block_broken.emit(global_position)
		broken = true
	queue_free()
