extends Area2D

onready var player = get_parent().get_parent().get_node("Player")

func _physics_process(delta):
	if overlaps_body(player):
		if get_parent().get_node("take_dmg").dead == false:
			player.kb = true
			player.dmg()
