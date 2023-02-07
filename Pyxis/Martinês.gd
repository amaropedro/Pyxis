extends Area2D

onready var player = get_parent().get_parent().get_node("Player")

func _physics_process(delta):
	if overlaps_body(player):
		player.dmg()
	elif overlaps_area(player.get_node("sword")):
		die()

func die():
	get_parent().queue_free()

