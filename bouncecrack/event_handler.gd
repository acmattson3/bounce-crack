extends Node

signal block_broken(location)
signal create_ball(location, direction, speed) # Emit me to make a new ball!
signal game_over(game_won)
var is_game_over := false
var start := false

var score: int = 0:
	set(value):
		score = value if value >= 0 else 0

func _ready() -> void:
	block_broken.connect(_on_block_broken)
	game_over.connect(_on_game_over)

func _on_block_broken(location):
	score += 1

func _on_game_over(_game_won):
	is_game_over = true
	
func on_starting(on_press):
	start = true
	
func switch_scene(to_scene_path: String):
	var next_scene = load(to_scene_path) 
	if next_scene: # Ensure the scene path is valid.
		# Change to the new scene.
		get_tree().call_deferred("change_scene_to_packed", next_scene)
	else:
		print("Failed to load scene: ", to_scene_path) 
