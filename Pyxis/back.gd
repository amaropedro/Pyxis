extends Area2D

onready var player = get_parent().get_node("Player")

func _physics_process(delta):
	if overlaps_body(player):
		$AnimatedSprite.play("Int")
		if player.interacting:
			player.position.x = 1079
			player.position.y = -423
	else:
		$AnimatedSprite.play("none")
