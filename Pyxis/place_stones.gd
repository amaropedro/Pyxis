extends Area2D

onready var player = get_parent().get_node("Player")

func _physics_process(delta):
	if overlaps_body(player):
		$AnimatedSprite.play("Int")
		if player.interacting:
			if player.atk_stone:
				if player.jump_stone:
					if player.shoot_stone:
						get_tree().change_scene("res://LvFinal.tscn")
						get_parent().get_node("Player").save_save(player.atk_stone, player.jump_stone, player.shoot_stone, 0, 0)
	else:
		$AnimatedSprite.play("none")
