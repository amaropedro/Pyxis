extends Area2D

onready var player = get_parent().get_parent().get_node("Player")
onready var player_sword = get_parent().get_parent().get_node("Player").get_node("sword")
var dead = false
var HP = 1
var i_frames = 0

func _physics_process(delta):
	if overlaps_body(player):
		if dead == false:
			player.kb = true
			player.dmg()
	if overlaps_area(player_sword) and i_frames <= 0:
		take_dmg()
	if HP <= 0:
		dead = true 
	i_frames -= 1

func take_dmg():
	HP -= 1
	i_frames = 25
	#print(HP)
