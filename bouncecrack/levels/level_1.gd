extends BaseLevel


func _ready() -> void:
	super._ready() # Call the BaseLevel _ready() function
	# Do things unique to level_1!

func _physics_process(delta: float) -> void:
	super._physics_process(delta) # Call the BaseLevel _physics_process() function
	# Do things unique to level_1!
