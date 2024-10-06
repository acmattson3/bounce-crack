extends BaseLevel
# demo_level_2d.gd 
# Inherits from base_level_2d.gd
#
# This means that all functions in that script are callable here. 
# "super" is areference to the script we inherit from, in the 
# same way that "self" is a reference to our own script.
# 
# In this script, we can do things unique to just this level! 
# That could be certain block layouts, moving blocks, special
# abilities or behaviors, or anything else you can imagine. This
# allows for an extensible level-making format to very easily
# create new levels going forward.

func _ready() -> void:
	super._ready() # Call the BaseLevel _ready() function
	# Do things unique to DemoLevel!

func _physics_process(delta: float) -> void:
	super._physics_process(delta) # Call the BaseLevel _physics_process() function
	# Do things unique to DemoLevel!
