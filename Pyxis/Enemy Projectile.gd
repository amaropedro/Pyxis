extends Area2D

const SPEED = 80

var motion = Vector2()

onready var player = get_parent().get_node("Player")

func _physics_process(delta):
	motion.y = SPEED * delta
	translate(motion)
	if overlaps_body(player):
		player.dmg()
		queue_free()


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
