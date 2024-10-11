extends Node2D
class_name BaseLevel
# The base level scene for all future levels to inheret from
# Includes any core functionalities common to all forseeable levels

@export var ball_on_break: bool = false # Do we spawn balls on breaking blocks?
@export var rainbow_on_break: bool = true # Do we spawn rainbows on breaking blocks?
var ball_scene: PackedScene = load("res://ball/ball_2d.tscn")

func _ready() -> void:
	EventHandler.game_over.connect(_on_game_over)
	EventHandler.create_ball.connect(_on_create_ball)
	EventHandler.block_broken.connect(_on_block_broken)
	EventHandler.exit_to_menu.connect(_on_exit_to_menu)

func _physics_process(_delta):
	if $Balls.get_child_count() == 0 and not EventHandler.is_game_over:
		EventHandler.game_over.emit(false) # You lose!
	if $Blocks.get_child_count() <= 0 and not EventHandler.is_game_over:
		EventHandler.game_over.emit(true) # You win!

func _on_game_over(game_won):
	$GameOverScreen.show()
	if game_won:
		%TempGameOverLabel.text = "You win!"
	else:
		%TempGameOverLabel.text = "You lose!"
	
	%TempScoreLabel.text = "Total score: "+str(EventHandler.score)
	
	print(%TempGameOverLabel.text)
	print(%TempScoreLabel.text)

func _on_block_broken(location):
	if ball_on_break:
		EventHandler.create_ball.emit(location)
	if rainbow_on_break:
		spawn_rainbow(location)

func spawn_rainbow(_location := Vector2.ZERO):
	pass # Write me Kylie!

func _on_create_ball(location := Vector2.ZERO, direction := Vector2.DOWN, speed := 1200.0):
	var new_ball = ball_scene.instantiate()
	new_ball.global_position = location
	new_ball.direction = direction
	new_ball.speed = speed
	$Balls.add_child.call_deferred(new_ball)
	
func _on_exit_to_menu():
	queue_free()

func _on_restart_button_pressed() -> void:
	var prev_name = name
	name = "queued_level"
	EventHandler.start_level(prev_name)
	queue_free()

func _on_exit_to_menu_button_pressed() -> void:
	EventHandler.exit_to_menu.emit()
	queue_free()
