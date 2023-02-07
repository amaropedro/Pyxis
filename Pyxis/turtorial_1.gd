extends Area2D

onready var player = get_parent().get_node("Player")
var seen_first = false
var seen_second = false
var playing = "none"


func _physics_process(delta):
	
	if player.atk_stone == true:
		$AnimatedSprite.play("none")
	else:
		$AnimatedSprite.play(playing)
		
		if overlaps_body(player):
			if !seen_first:
				playing = "walk_t"
				if player.interacting:
					seen_first = true
			elif !seen_second:
				playing = "jump_t"
				if player.interacting:
					seen_second = true
		else:
			playing = "none"
		if seen_first and seen_second:
			get_parent().get_node("to_inside_spaceship").cango = true
			playing = "none"

