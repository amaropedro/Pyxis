extends Area2D

onready var little = get_parent().get_node("Little")

func _physics_process(delta):
	if overlaps_body(little):
		little.move = false
		little.motion.x = 0
		little.motion.y = -300
