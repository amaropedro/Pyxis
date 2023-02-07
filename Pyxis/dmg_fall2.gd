extends Area2D

onready var arleand = get_parent().get_node("Arleand")

func _physics_process(delta):
	
	var player = get_parent().get_node("Player")
	
	if overlaps_body(player):
			player.position.x = player.last_ground.x
			player.position.y = player.last_ground.y
			player.kb = false
			player.dmg()
	
	if overlaps_body(arleand):
		arleand.position.x = -2423
		arleand.position.y = 432
