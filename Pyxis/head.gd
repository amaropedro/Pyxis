extends Area2D

onready var player_sword = get_parent().get_parent().get_node("Player/sword")
onready var hitbox = get_parent().get_node("hitbox")

func _physics_process(delta):
	if overlaps_area(player_sword) and hitbox.i_frames <=0:
		hitbox.take_dmg()
