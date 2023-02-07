extends Area2D

onready var player = get_parent().get_node("Player")
var seen_first = false
var playing = "none"


func _physics_process(delta):
	
	if player.atk_stone == true:
		$AnimatedSprite.play("none")
	else:
		$AnimatedSprite.play(playing)
		
		if overlaps_body(player):
			if !seen_first:
				playing = "slow fall_t"
				if player.interacting:
					seen_first = true
		else:
			playing = "none"
		if seen_first:
			playing = "none"

