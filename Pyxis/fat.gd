extends Area2D

onready var player = get_parent().get_node("Player")

func _physics_process(delta):
	$AnimatedSprite.play("none")
	if overlaps_body(player):
		$AnimatedSprite.play("Int")
		if player.interacting:
			player.scale.x = 4
			player.scale.y = 0.5
