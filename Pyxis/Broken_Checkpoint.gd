extends Area2D

onready var player = get_parent().get_parent().get_node("Player")
onready var interact_t = get_parent().get_node("AnimatedSprite")
var active = false

func _physics_process(delta):
	
	if player.last_checkpoint == get_parent().current_lv:
		active = true
	else:
		active = false
	
	if overlaps_body(player):
		interact_t.play("interact_t")
		if player.interacting:
			player.last_checkpoint = get_parent().current_lv
			player.HP = 3
			player.update_hud()
			player.last_pos.x = get_parent().position.x
			player.last_pos.y = get_parent().position.y
			player.checkpoint_pos.x = get_parent().position.x
			player.checkpoint_pos.y = get_parent().position.y
			player.save_save(player.atk_stone, player.jump_stone, player.shoot_stone, get_parent().position.x, get_parent().position.y-10)
			player.canmove = false
			player.canfall = false
			player.no_animation = true
			if active:
				get_parent().play("on")
				player.get_node("AnimatedSprite").play("none")
				yield(get_parent(), "animation_finished")
				player.no_animation = false
				player.canmove = true
				player.canfall = true
				get_parent().play("still on")
			else:
				get_parent().play("off")
				player.get_node("AnimatedSprite").play("none")
				yield(get_parent(), "animation_finished")
				player.no_animation = false
				player.canmove = true
				player.canfall = true
				active = true
				get_parent().play("still on")
	else:
		interact_t.play("none")
		if active:
			get_parent().play("still on")
		else:
			get_parent().play("still off")
