extends Node2D
class_name BaseLevel
# The base level scene for all future levels to inheret from
# Includes any core functionalities common to all forseeable levels

@export var ball_on_break: bool = false # Do we spawn balls on breaking blocks?
@export var rainbow_on_break: bool = true # Do we spawn rainbows on breaking blocks?
@export var power_up_on_break: bool = true # Do we spawn power ups on breaking blocks?
@export_range(0.0, 1.0) var power_up_probability: float = 0.1

var ball_scene: PackedScene = load("res://ball/ball_2d.tscn")
var ball_power_up_scene: PackedScene = load("res://power_up/spawn_ball_power_up.tscn")
var paddle_speed_power_up_scene: PackedScene = load("res://power_up/paddle_speed_power_up.tscn")
var paddle_size_power_up_scene: PackedScene = load("res://power_up/paddle_size_power_up.tscn")

const POWER_UP_TYPES = 3

func _ready() -> void:
	EventHandler.game_over.connect(_on_game_over)
	EventHandler.create_ball.connect(_on_create_ball)
	EventHandler.block_broken.connect(_on_block_broken)
	EventHandler.exit_to_menu.connect(_on_exit_to_menu)

func _physics_process(_delta):
	# There are no more balls
	if $Balls.get_child_count() == 0 and not EventHandler.is_game_over:
		# We may still have a chance!
		var has_chance := false # Assume we don't
		for child in $PowerUps.get_children():
			if child is SpawnBall: # We can spawn more balls!
				has_chance = true
				break
			# Can check other types of power ups going forward.
		if not has_chance: # No chance of winning!
			EventHandler.game_over.emit(false) # You lose!
	
	# There are no more blocks
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
	var new_power_up = ball_power_up_scene.instantiate()

	var rand_result = randi_range(1, POWER_UP_TYPES)
	
	if (rand_result == 1):
		new_power_up = ball_power_up_scene.instantiate()
	elif (rand_result == 2):
		new_power_up = paddle_speed_power_up_scene.instantiate()
	elif (rand_result == 3):
		new_power_up = paddle_size_power_up_scene.instantiate()
	
	new_power_up.global_position = location
	# Can add logic here to change power up parameters in overwrites of this function.
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
