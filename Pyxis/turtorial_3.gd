extends Area2D

onready var player = get_parent().get_node("Player")
var seen_first = false
var playing = "none"
var canplay = false


func _physics_process(delta):
	
	$AnimatedSprite.play(playing)
	
	if canplay:
		if overlaps_body(player):
			if !seen_first:
				playing = "attack_t"
				if player.interacting:
					seen_first = true
		else:
			playing = "none"
		if seen_first:
			playing = "none"

