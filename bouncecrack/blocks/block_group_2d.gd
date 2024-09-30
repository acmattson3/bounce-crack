@tool # Runs this script in the editor
extends Node2D
# A group of blocks. Controls motion of the entire group, how many blocks to
# have, etc etc.

var block_scene := load("res://blocks/breakable_block.tscn")
const block_dims := Vector2(194.0, 80.0)

@export var group_size_x: int = 4
@export var group_size_y: int = 4
@export var spacing: float = 10.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var total_size := Vector2(group_size_x*(block_dims.x + spacing) - spacing, group_size_y*(block_dims.y + spacing) - spacing)
	# Box shows what the size of the group of blocks will be!
	$GroupArea2D/CollisionShape2D.shape.size = total_size
	
	for i in range(group_size_y):
		var y_pos := 0.5*(block_dims.y-total_size.y) + i*(block_dims.y+spacing)
		for j in range(group_size_x):
			var x_pos = 0.5*(block_dims.x-total_size.x) + j*(block_dims.x+spacing)
			var new_block = block_scene.instantiate()
			add_child(new_block)
			new_block.position = Vector2(x_pos, y_pos)
