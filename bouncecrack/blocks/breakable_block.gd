extends Node2D
class_name BreakableBlock

var broken: bool = false

func _ready():
	EventHandler.toggle_brownies.connect(_on_toggle_brownies)
	if EventHandler.brownie_mode:
		_on_toggle_brownies(true)

func _on_toggle_brownies(do_brownies):
	if do_brownies:
		$BrownieBlock.show()
		$BluePurpleBlock.hide()
	else:
		$BrownieBlock.hide()
		$BluePurpleBlock.show()

func break_block():
	if not broken:
		EventHandler.block_broken.emit(global_position)
		broken = true
	queue_free()
