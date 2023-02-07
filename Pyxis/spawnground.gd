extends Node2D

const EXIT = preload("res://Exit.tscn")
const GROUNDSPAWNER = preload("res://platform.tscn")
const GORUNDWIDTH = 80
var spawn_position = global_position
var aux = true
onready var player = get_parent().get_node("Player")

func _process(delta):
	if spawn_position.distance_to(player.global_position) < 300:
		if player.lulaHP > 0:
			spawn_ground()
		elif player.lulaHP <= 0:
			if aux:
				spawn_exit()

func spawn_ground():
		var spawn_ground_instance = GROUNDSPAWNER.instance()
		add_child(spawn_ground_instance)
		spawn_ground_instance.global_position.x = spawn_position.x
		spawn_ground_instance.global_position.y = spawn_position.y
		
		randomize()
		
		spawn_position.x = spawn_position.x + rand_range(GORUNDWIDTH, GORUNDWIDTH + 50)
		spawn_position.y = spawn_position.y + rand_range(-40,40)

func spawn_exit():
	var spawn_ground_instance = EXIT.instance()
	aux = false
	player.lulaHP = -1
	add_child(spawn_ground_instance)
	spawn_ground_instance.global_position.x = spawn_position.x
	spawn_ground_instance.global_position.y = spawn_position.y
