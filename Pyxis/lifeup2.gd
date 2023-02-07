extends Area2D

onready var player = get_parent().get_node("Player")
onready var player_sword = get_parent().get_node("Player/sword")
var broken = false
var playing = false

func _physics_process(delta):
	if player.life_up2 or broken:
		queue_free()
	elif !playing:
		if overlaps_area(player_sword):
			anim()
		else:
			$AnimatedSprite.play("chained")


func anim():
	playing = true
	$AnimatedSprite.play("break")
	yield($AnimatedSprite,"animation_finished")
	player.life_up2 = true
	heal()
	player.update_hud()
	broken = true

func heal():
	if player.life_up1 and player.life_up2 and player.life_up3 and player.life_up4:
		player.HP = 6
	else:
		player.HP = 5
