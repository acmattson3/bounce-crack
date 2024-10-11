extends CanvasLayer

var error_label_text: String = "":
	set(value):
		if value != "":
			%ErrorLabel.show()
			%ErrorLabel.text = value
		else:
			%ErrorLabel.hide()
			%ErrorLabel.text = ""
		error_label_text = value

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	EventHandler.exit_to_menu.connect(_on_exit_to_menu)
	
	process_mode = PROCESS_MODE_ALWAYS # We aren't affected by pausing
	for button in %LevelsGridContainer.get_children():
		button.pressed.connect(_handle_level_button.bind(button.name))


func _handle_level_button(button_name):
	EventHandler.start_level(button_name)
	hide()

func _on_exit_to_menu(error: String = ""):
	await get_tree().process_frame
	show()
	error_label_text = error
	$MenuContainer.show()
	$LevelsContainer.hide()

func _on_view_levels_button_pressed() -> void:
	$MenuContainer.hide()
	$LevelsContainer.show()

func _on_back_button_pressed() -> void:
	$MenuContainer.show()
	$LevelsContainer.hide()

func _on_play_button_pressed() -> void:
	EventHandler.start_level("demo_level_2d")
	hide()
