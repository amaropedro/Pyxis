extends Area2D

func _physics_process(delta):
	
	var player = get_parent().get_node("Player")
	
	if overlaps_body(player):
			player.position.x = player.last_ground.x
			player.position.y = player.last_ground.y
			player.kb = false
			player.dmg()
