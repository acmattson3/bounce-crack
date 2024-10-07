extends Label

var play_scene: String = "res://levels/base_level_2d.gd"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_process_input(true) 

func _input(ev):
	if ev == KEY_ENTER:
		print("hi")
		EventHandler.switch_scene(play_scene)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
