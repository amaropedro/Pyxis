extends Area2D

onready var player = get_parent().get_node("Player")

func _physics_process(delta):
	if overlaps_body(player) and player.life_up1 and player.life_up2 and player.life_up3 and player.life_up4:
		$AnimatedSprite.play("Int")
		if player.interacting:
			get_parent().get_node("door2").play("open")
			player.canfall = false
			player.canmove = false
			player.no_animation = true
			yield(get_parent().get_node("door2"),"animation_finished")
			player.no_animation = false
			player.canfall = true
			player.canmove = true
			player.position.x = 1517
			player.position.y = -439
	else:
		get_parent().get_node("door2").play("still")
		$AnimatedSprite.play("none")
