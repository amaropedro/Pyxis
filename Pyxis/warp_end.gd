extends Area2D

onready var player = get_parent().get_parent().get_parent().get_node("Player")

func _physics_process(delta):
	if overlaps_body(player):
		get_tree().change_scene("res://World.tscn")
		player.last_checkpoint = ("res://World.tscn")
		player.checkpoint_pos = Vector2(-364, -797)
		player.save_save(player.atk_stone, player.jump_stone, player.shoot_stone, 0, 0)
