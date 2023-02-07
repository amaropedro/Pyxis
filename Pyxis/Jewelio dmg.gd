extends Area2D

onready var player = get_parent().get_parent().get_node("Player")
onready var player_sword = get_parent().get_parent().get_node("Player").get_node("sword")
var dead = false
var HP = 12
var armor = 2
var i_frames = 0
var atk = false

func _physics_process(delta):
	
	if overlaps_body(player) and get_parent().stun_timer < 0:
		if dead == false:
			player.kb = true
			player.dmg()
	
	if (overlaps_area(player_sword) or get_parent().get_node("Arms").overlaps_area(player_sword)) and i_frames <= 0:
		get_parent().no_hit_timer = 0
		if armor > 0:
			armor -= 1
			i_frames = 25
		else:
			atk = true
		if get_parent().stun_timer >=0 :
			take_dmg()
	
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
