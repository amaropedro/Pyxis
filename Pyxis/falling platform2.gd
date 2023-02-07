extends Sprite

func _physics_process(delta):
	position.y += 1
	if position.y >=305:
		position.y = 47
