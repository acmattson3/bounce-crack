extends Node

signal block_broken(location)
signal create_ball(location, direction, speed) # Emit me to make a new ball!
signal game_over

var score: int = 0:
	set(value):
		score = value if value >= 0 else 0

var total_balls: int:
	set(value):
		if value <= 0:
			game_over.emit()
		total_balls = value

func _ready() -> void:
	block_broken.connect(_on_block_broken)
	create_ball.connect(_on_create_ball)

func _on_block_broken(location):
	create_ball.emit(location)
	score += 1

func _on_create_ball(_location := Vector2.ZERO, _direction := Vector2.DOWN, _speed := 1200.0):
	total_balls += 1
