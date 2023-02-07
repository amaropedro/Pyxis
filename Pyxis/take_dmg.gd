extends Area2D

const IFRAMES = 100

var cannotmove_timer = 0 
var dmg = false
var invencible = false
var itimer = 0
var dead = false
onready var player = get_parent().get_parent().get_node("Player")

func _physics_process(delta):
	
	cannotmove_timer -= 1
	if cannotmove_timer <= 0:
		player.canmove = true
		
	itimer -= 1
	if itimer <= 0:
		invencible = false
	
	var player_feet = get_parent().get_parent().get_node("Player").get_node("Area2D")
	
	if overlaps_area(player_feet):
		if !invencible:
			dmg = true
			get_parent().HP -= 1
			
			#print("TOMOU DANO")
			invencible = true
			itimer = IFRAMES
		
		if player.facing_right == true:
			player.motion.x = -300
		else:
			player.motion.x = 300
		player.motion.y =-250
		
		player.canmove = false
		cannotmove_timer = 25
		
		if get_parent().HP <= 0:
			dead = true

