extends PanelContainer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	process_mode = PROCESS_MODE_ALWAYS # We are unaffected by pausing the scene tree.
	get_tree().paused = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("enter") or Input.is_action_just_pressed("escape") and visible:
		get_tree().paused = false
		hide()
	elif Input.is_action_just_pressed("escape") and not visible:
		show()
		get_tree().paused = true

func _on_exit_to_menu_button_pressed() -> void:
	EventHandler.exit_to_menu.emit()
	queue_free()
