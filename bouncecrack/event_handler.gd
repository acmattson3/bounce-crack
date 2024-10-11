extends Node

# Menu signals
signal exit_to_menu(error)

# Game signals
signal block_broken(location)
signal create_ball(location, direction, speed) # Emit me to make a new ball!
signal game_over(game_won)
var is_game_over := false

var score: int = 0:
	set(value):
		score = value if value >= 0 else 0

func _ready() -> void:
	block_broken.connect(_on_block_broken)
	game_over.connect(_on_game_over)

func _on_block_broken(_location):
	score += 1

func _on_game_over(_game_won):
	is_game_over = true

# Expects level_name to be the name of the level scene (minus .tscn)
func start_level(level_name: String, advance_level := false):
	var level_path := ""
	if advance_level:
		var level_num: int = level_name.lstrip("level_").to_int() + 1
		print(level_name.lstrip("level_"))
		level_path = "res://levels/level_"+str(level_num)+".tscn"
	else:
		level_path = "res://levels/"+level_name+".tscn"
	
	var level = load(level_path)
	if level:
		is_game_over = false
		score = 0
		get_tree().root.add_child(level.instantiate(), true)
	else:
		print("Failed to load scene: ", level_path)
		exit_to_menu.emit("Failed to load scene: "+level_path)
