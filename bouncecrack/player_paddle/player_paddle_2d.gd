@tool
extends CharacterBody2D
class_name Paddle

@export var paddle_width: float = 195.0:
	set(value):
		$CollisionShape2D.shape.size.x = value
		$TempPlayerPaddle.scale.x *= value / paddle_width
		paddle_width = value

@export var speed = 900.0

var last_press_pos: Vector2 = Vector2.ZERO
var pressing = false
func _input(event):
	if event is InputEventMouseButton and event.pressed:
		pressing = true
		last_press_pos = event.global_position - get_viewport().get_visible_rect().size/2
		print("Clicked at: ", event.global_position)  # Global position in the viewport
		print("Paddle at: ", global_position)
	elif event is InputEventMouseMotion and pressing:
		last_press_pos = event.global_position - get_viewport().get_visible_rect().size/2
	elif event is InputEventMouseButton and not event.pressed:
		pressing = false
		print("Unclicked at:", event.global_position)  # Global position in the viewport

func _physics_process(_delta: float) -> void:
	if Engine.is_editor_hint():
		return # Allows us to use @tool without breaking the editor
	var direction := Input.get_axis("paddle_left", "paddle_right")
	if not direction:
		if pressing:
			var press_x_offset = last_press_pos.x*2 - global_position.x
			if press_x_offset < -5.0:
				direction = -1.0
			elif press_x_offset > 5.0:
				direction = 1.0
	if direction:
		velocity.x = direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
	
	
	move_and_slide()
