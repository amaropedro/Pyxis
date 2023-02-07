extends KinematicBody2D

func _physics_process(delta):
	position.y += 1
	if position.y >=330:
		position.y = 70
