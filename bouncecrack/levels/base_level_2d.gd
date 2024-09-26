extends Node2D
class_name BaseLevel
# The base level scene for all future levels to inheret from
# Includes any core functionalities common to all forseeable levels

var ball_scene: PackedScene = load("res://ball/ball_2d.tscn")

func _ready() -> void:
	EventHandler.game_over.connect(_on_game_over)
	EventHandler.create_ball.connect(_on_create_ball)
	EventHandler.total_balls = $Balls.get_child_count()

func _on_game_over():
	print("Game over!")
	print("Total score: ", EventHandler.score)

func _on_create_ball(location := Vector2.ZERO, direction := Vector2.DOWN, speed := 1200.0):
	var new_ball = ball_scene.instantiate()
	new_ball.global_position = location
	new_ball.direction = direction
	new_ball.speed = speed
	$Balls.add_child.call_deferred(new_ball)
