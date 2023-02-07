extends Area2D

var i_frames = 0
var dead = false
var HP = 3
onready var player_sword = get_parent().get_parent().get_node("Player").get_node("sword")

func _physics_process(delta):
	if overlaps_area(player_sword) and i_frames <= 0:
		take_dmg()
	if HP <= 0:
		dead = true
		 
	i_frames -= 1
	
	if i_frames >=0:
		get_parent().modulate = Color(2,2,2)
	else:
		get_parent().modulate = Color(1,1,1)

func take_dmg():
	HP -= 1
	i_frames = 25
	#print(HP)
	get_parent().was_hit()
