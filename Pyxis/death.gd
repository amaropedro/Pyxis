extends Area2D

var dead = false
onready var player_feet = get_parent().get_parent().get_node("Player").get_node("Area2D")
onready var player_swrod = get_parent().get_parent().get_node("Player").get_node("sword")

func _physics_process(delta):
	if overlaps_area(player_feet) or overlaps_area(player_swrod):
		dead = true


