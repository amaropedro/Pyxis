extends Area2D

onready var little = get_parent().get_node("Little")

func _physics_process(delta):
	if overlaps_body(little):
		little.motion.y = -200
		get_parent().get_node("Springus").position.x = 330
