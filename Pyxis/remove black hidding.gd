extends Area2D

func _physics_process(delta):
	if overlaps_body(get_parent().get_node("Player")):
		get_parent().get_node("black_hidding 1").modulate = Color(1, 1, 1)
		get_parent().get_node("black_hidding 2").modulate = Color(0, 0, 0, 0)
		get_parent().get_node("black_hidding 3").modulate = Color(1, 1, 1)
	else:
		get_parent().get_node("black_hidding 1").modulate = Color(1, 1, 1)
		get_parent().get_node("black_hidding 2").modulate = Color(1, 1, 1)
		get_parent().get_node("black_hidding 3").modulate = Color(0, 0, 0, 0)
