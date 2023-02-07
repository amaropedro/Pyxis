extends Area2D

onready var player = get_parent().get_parent().get_node("Player")
onready var player_sword = get_parent().get_parent().get_node("Player").get_node("sword")
var dead = false
var HP = 24
var armor = 2
var i_frames = 0
var atk = false

func _physics_process(delta):
	
	
	if i_frames <= 0:
		if overlaps_body(player):
			if dead == false:
				player.kb = true
				player.dmg()
				
		if overlaps_area(player_sword):
				take_dmg()
		
		if get_parent().get_node("feet_hitbox").overlaps_area(player.get_node("Area2D")):
			take_dmg()
			player.kb = true
			player.knockback()
	
	if HP <= 0:
		dead = true 
	
	i_frames -= 1
	
	if i_frames < 0:
		get_parent().modulate = Color(1,1,1)

func take_dmg():
	HP -= 1
	get_parent().modulate = Color(2,2,2)
	i_frames = 25
	print(HP)
