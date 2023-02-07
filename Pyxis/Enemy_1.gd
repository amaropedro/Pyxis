extends KinematicBody2D

const UP = Vector2(0,-1)

var motion = Vector2()
var direction = -1

func _ready():
	$floor_check.position.x = $CollisionShape2D.shape.get_extents().x * direction

func _physics_process(delta):
	
	if is_on_wall() or !$floor_check.is_colliding():
		direction *= -1
		$floor_check.position.x = $CollisionShape2D.shape.get_extents().x * direction
	
	if get_node("Enemy Die").dead == true:
		die()
	else:
		motion.x = 25 * direction
		motion.y += 20
		$AnimatedSprite.play("Walk")
	
	if direction > 0:
		$AnimatedSprite.scale.x = -1
	else:
		$AnimatedSprite.scale.x = 1
	
	motion = move_and_slide(motion,UP)

func die():
	motion.x = 0
	motion.y = 0
	$AnimatedSprite.play("Death")
	get_node("CollisionShape2D").disabled = true
	get_node("Dmg player/CollisionShape2D").disabled = true
	get_node("Enemy Die/CollisionShape2D").disabled = true
	yield($AnimatedSprite, "animation_finished")
	queue_free()
