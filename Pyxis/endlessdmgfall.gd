extends Area2D

onready var player = get_parent().get_parent().get_parent().get_node("Player")

func _physics_process(delta):
	if overlaps_body(player):
		player.kb = false
		player.dmg()
		get_tree().change_scene("res://endlessrunner.tscn")
		player.save_save(player.atk_stone, player.jump_stone, player.shoot_stone, 0, 0)
		
