extends Area2D

onready var player = get_parent().get_parent().get_node("Player")

func _physics_process(delta):
	if overlaps_body(player):
		if get_parent().warp_player == true:
			player.position.x = player.last_ground.x
			player.position.y = player.last_ground.y
		player.kb = true
		player.dmg()
