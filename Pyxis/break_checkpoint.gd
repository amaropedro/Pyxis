extends Area2D

onready var player = get_parent().get_parent().get_node("Player")
onready var player_swrod = get_parent().get_parent().get_node("Player/sword")
onready var checkpoint = get_parent().get_parent().get_node("Checkpoint")
var hp = 150

func _physics_process(delta):
	
	if hp <= 0 or player.checkpoint_freed:
		get_parent().play("broaken")
		checkpoint.position.y = 229
		player.checkpoint_freed = true
	else:
		checkpoint.position.y = 300
		if overlaps_area(player_swrod):
			if hp>75:
				get_parent().play("break 1")
			else:
				get_parent().play("break 2")
			hp -= 1
		else:
			if hp>75:
				get_parent().play("still 1")
			else:
				get_parent().play("still 2")
