extends Area2D

const SPEED = 350

var motion = Vector2()
var direction = 1
onready var player = get_parent().get_node("Player")

func set_direction(dir):
	direction = dir
	if dir == -1:
		$"player projectile".scale.x = -1

func _physics_process(delta):
	motion.x = SPEED * delta * direction
	translate(motion)
	$"player projectile".play("Shoot")

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()


func _on_Player_Projectile_body_entered(body):
	if "Springus" in body.name:
		body.get_node("Enemy Die").dead = true
	if "Vitu" in body.name:
		body.get_node("vitu_hitbox").dead = true 
	if "Tuvi" in body.name:
		body.get_node("vitu_hitbox").dead = true 
	if "Arleand" in body.name:
		body.get_node("hitbox").take_dmg()
	if "Pedra-Looka" in body.name:
		body.get_node("Area2D").take_dmg()
	if "Martinês" in body.name:
		body.get_node("hitbox").die()
	if "The Lula" in body.name:
		body.take_dmg()
	if "lifeup" in body.name:
		body.get_parent().anim()
	queue_free()
