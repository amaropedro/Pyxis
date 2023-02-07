extends Area2D

onready var player_feet = get_parent().get_parent().get_node("Player").get_node("Area2D")
onready var hitbox = get_parent().get_node("hitbox")

func _physics_process(delta):
	if hitbox.i_frames <= 0:
		if overlaps_area(player_feet):
			hitbox.take_dmg()
