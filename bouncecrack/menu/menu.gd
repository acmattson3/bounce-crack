extends CanvasLayer

var levels: Array

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
	
	process_mode = PROCESS_MODE_ALWAYS # # We are unaffected by pausing the scene tree.
	
	#for level: String in EventHandler.get_levels():
		#var new_button := Button.new()
		#new_button.add_theme_font_size_override("font_size", 48)
		#new_button.name = level.rstrip(".tscn")
		#new_button.text = new_button.name.capitalize()
		#new_button.size_flags_horizontal = Control.SIZE_EXPAND_FILL
		#new_button.pressed.connect(_handle_level_button.bind(level))
		#%LevelsGridContainer.add_child(new_button, true)
	
	# Buttons are hard coded for export support
	for button in %LevelsGridContainer.get_children():
		button.pressed.connect(_handle_level_button.bind(button.name+".tscn"))


func _handle_level_button(level_name):
	print("_handle_level_button: ", level_name)
	EventHandler.start_level(level_name)
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
	EventHandler.start_level("demo_level.tscn")
	hide()
