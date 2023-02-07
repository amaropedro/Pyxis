extends Area2D

onready var little = get_parent().get_node("Little")
onready var player = get_parent().get_node("Player")

func _physics_process(delta):
	if overlaps_body(player):
		little.move = true
