extends Area2D

onready var player_feet = get_parent().get_parent().get_node("Player/Area2D")

func _physics_process(delta):
	if overlaps_area(player_feet):
		get_parent().get_node("vitu_hitbox/CollisionShape2D").disabled = true
		get_parent().get_node("vitu_hitbox/CollisionShape2D2").disabled = true
		get_parent().get_node("vitu_hitbox/CollisionShape2D3").disabled = true
		get_parent().get_node("vitu_hitbox").take_dmg()
