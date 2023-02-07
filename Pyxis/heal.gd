extends Area2D

onready var player = get_parent().get_node("Player")
var maxhp

func _ready():
	setmaxhp()

func _physics_process(delta):
	$AnimatedSprite.play("heal")
	
	if overlaps_body(player):
		if player.HP < maxhp:
			player.HP += 1
			print(player.HP)
			player.update_hud()
		queue_free()

func setmaxhp():
	if player.life_up1 and player.life_up2 and player.life_up3 and player.life_up4:
		maxhp = 6
	else:
		maxhp = 5
