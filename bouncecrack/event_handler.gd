extends Node

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

func _on_block_broken(location):
	score += 1

func _on_game_over(_game_won):
	is_game_over = true
