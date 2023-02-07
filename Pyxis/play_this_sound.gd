extends Area2D

onready var player = get_parent().get_node("Player")
onready var sound = get_parent().get_node("AudioStreamPlayer2D")

func _physics_process(delta):
	#if overlaps_body(player) and !sound.playing:
		#sound.play()
	pass
