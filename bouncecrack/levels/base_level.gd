extends Node2D
class_name BaseLevel
# The base level scene for all future levels to inheret from
# Includes any core functionalities common to all forseeable levels

@export var ball_on_break: bool = false # Do we spawn balls on breaking blocks?
@export var rainbow_on_break: bool = true # Do we spawn rainbows on breaking blocks?
@export var power_up_on_break: bool = true
@export_range(0.0, 1.0) var power_up_probability: float = 0.1

var ball_scene: PackedScene = load("res://ball/ball_2d.tscn")
var power_up_scene: PackedScene = load("res://power_up/power_up.tscn")

func _ready() -> void:
	EventHandler.game_over.connect(_on_game_over)
	EventHandler.create_ball.connect(_on_create_ball)
	EventHandler.block_broken.connect(_on_block_broken)
	EventHandler.exit_to_menu.connect(_on_exit_to_menu)

func _physics_process(_delta):
	if $Balls.get_child_count() == 0 and not EventHandler.is_game_over:
		if $PowerUps.get_child_count() == 0: # We still have a chance!
			EventHandler.game_over.emit(false) # You lose!
	if $Blocks.get_child_count() <= 0 and not EventHandler.is_game_over:
		EventHandler.game_over.emit(true) # You win!

func _on_game_over(game_won):
	$GameOverScreen.show()
	if game_won:
		%TempGameOverLabel.text = "You win!"
		%NextLevelButton.show()
		%Spacer4.show()
	else:
		%TempGameOverLabel.text = "You lose!"
		%NextLevelButton.hide()
		%Spacer4.hide()
	
	%TempScoreLabel.text = "Total score: "+str(EventHandler.score)
	
	print(%TempGameOverLabel.text)
	print(%TempScoreLabel.text)

func _on_block_broken(location):
	if ball_on_break:
		EventHandler.create_ball.emit(location)
	if rainbow_on_break:
		spawn_rainbow(location)
	if power_up_on_break:
		if randf() <= power_up_probability:
			spawn_power_up(location)

func spawn_power_up(location := Vector2.ZERO):
	var new_power_up = power_up_scene.instantiate()
	new_power_up.global_position = location
	$PowerUps.add_child.call_deferred(new_power_up)

func spawn_rainbow(_location := Vector2.ZERO):
	pass # Write me Kylie!

func _on_create_ball(location := Vector2.ZERO, direction := Vector2.DOWN, speed := 1200.0):
	var new_ball = ball_scene.instantiate()
	new_ball.global_position = location
	new_ball.direction = direction
	new_ball.speed = speed
	$Balls.add_child.call_deferred(new_ball)

func _on_exit_to_menu(_error):
	queue_free()

func _on_restart_button_pressed() -> void:
	var prev_name = name
	name = "queued_level" # The new scene wants our name!
	EventHandler.start_level(prev_name+".tscn")
	queue_free()

func _on_exit_to_menu_button_pressed() -> void:
	EventHandler.exit_to_menu.emit("")
	queue_free()

func _on_next_level_button_pressed() -> void:
	EventHandler.start_level(name+".tscn", true)
	queue_free()
