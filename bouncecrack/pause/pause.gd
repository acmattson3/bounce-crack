@tool
extends PanelContainer

@export var level_name: String = "Unnamed level":
	set(value):
		%LevelNameLabel.text = value
		level_name = value

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if Engine.is_editor_hint():
		return # Allows us to use @tool without breaking the editor
	process_mode = PROCESS_MODE_ALWAYS # We are unaffected by pausing the scene tree.
	if EventHandler.brownie_mode:
		$VBoxContainer/HBoxContainer2/ToggleBrownies.set_pressed_no_signal(true)
	get_tree().paused = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Engine.is_editor_hint():
		return # Allows us to use @tool without breaking the editor
	if Input.is_action_just_pressed("space") or Input.is_action_just_pressed("escape") and visible:
		get_tree().paused = false
		hide()
	elif Input.is_action_just_pressed("escape") and not visible:
		show()
		get_tree().paused = true

func _on_exit_to_menu_button_pressed() -> void:
	EventHandler.exit_to_menu.emit("")
	queue_free()

func _on_restart_level_pressed() -> void:
	get_parent()._on_restart_button_pressed() # Cursed

func _on_toggle_brownies_toggled(toggled_on: bool) -> void:
	EventHandler.toggle_brownies.emit(toggled_on)
