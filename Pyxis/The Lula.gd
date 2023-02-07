extends KinematicBody2D

onready var player = get_parent().get_node("Player")
var i_frames = 0

func _ready():
	player.last_checkpoint = "res://endlessrunner.tscn"
	player.checkpoint_pos.x = 0
	player.checkpoint_pos.y = 0

func _physics_process(delta):
	if player.lulaHP > 0:
		if i_frames < -12:
			modulate = Color(1,1,1)
		if $Area2D.overlaps_body(player):
			player.dmg()
		i_frames -= 1
		position.x += 2.4
		if position.y > player.global_position.y:
			position.y -= 1
		elif position.y < player.global_position.y:
			position.y += 1
	else:
		die()

func take_dmg():
	if i_frames < -25:
		modulate = Color(2,2,2)
		player.lulaHP -= 1
		print(player.lulaHP)
		i_frames = 0

func die():
	queue_free()
