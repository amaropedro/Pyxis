extends Area2D
onready var player = get_parent().get_node("Player")
var overlaps_player
var defeated = false
var play = true

func _physics_process(delta):
	overlaps_player = overlaps_body(player)
	
	if overlaps_player and !defeated:
		get_parent().get_node("gate 1/CollisionShape2D").disabled = false
		get_parent().get_node("gate 1/CollisionShape2D/gate").position.y = 0
		get_parent().get_node("gate 1/CollisionShape2D/gate").scale.y = 1
		get_parent().get_node("gate 2/CollisionShape2D").disabled = false
		get_parent().get_node("gate 2/CollisionShape2D/gate").position.y = 0
		get_parent().get_node("gate 2/CollisionShape2D/gate").scale.y = 1
		get_parent().get_node("JUMP STONE").play("none")
	elif !overlaps_player:
		open()
	
	if defeated and play:
		if player.jump_stone == false:
			get_parent().get_node("JUMP STONE").play("shine")
	elif player.jump_stone == true:
		open()

func open():
	get_parent().get_node("gate 1/CollisionShape2D").disabled = true
	get_parent().get_node("gate 1/CollisionShape2D/gate").position.y = -36
	get_parent().get_node("gate 1/CollisionShape2D/gate").scale.y = 0.1
	get_parent().get_node("gate 2/CollisionShape2D").disabled = true
	get_parent().get_node("gate 2/CollisionShape2D/gate").position.y = -36
	get_parent().get_node("gate 2/CollisionShape2D/gate").scale.y = 0.1
