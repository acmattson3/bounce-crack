extends Node

# Menu signals
signal exit_to_menu(error)

var _levels: Array = []

# Game signals
signal block_broken(location)
signal create_ball(location, direction, speed) # Emit me to make a new ball!
signal game_over(game_won)
var is_game_over := false

var score: int = 0:
	set(value):
		score = value if value >= 0 else 0

func _ready() -> void:
	fill_levels()
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
		var new_level_idx: int = _levels.find(level_name)+1
		if new_level_idx < _levels.size():
			level_path = "res://levels/"+_levels[new_level_idx]
		else:
			print("All levels completed!")
			exit_to_menu.emit("All levels completed!")
			return
	else:
		level_path = "res://levels/"+level_name
	
	var level = load(level_path)
	if level:
		await get_tree().process_frame
		is_game_over = false
		score = 0
		get_tree().root.add_child(level.instantiate(), true)
	else:
		print("Failed to load scene: ", level_path)
		exit_to_menu.emit("Failed to load scene: "+level_path)

func fill_levels():
	_levels = []
	#var dir = DirAccess.open("res://levels")
	#if dir:
		#dir.list_dir_begin()
		#var filename = dir.get_next()
		#while filename != "":
			#if not dir.current_is_dir():
				#if filename.get_extension() == "tscn" and filename != "base_level.tscn":
					#_levels.append(filename)
			#filename = dir.get_next()
		#_levels.sort()
	#else:
		#print("Failed to open `res://levels` directory.")
	# Hard code levels for now (exports can't see traditional files!)
	_levels = ["demo_level.tscn", "level_1.tscn", "level_2.tscn"]

func get_levels():
	return _levels
