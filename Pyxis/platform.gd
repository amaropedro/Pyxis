extends StaticBody2D

onready var player = get_parent().get_parent().get_node("Player")

func _process(delta):
	if global_position.distance_to(player.global_position) > 300 and player.global_position.x > global_position.x:
		queue_free()
