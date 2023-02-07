extends KinematicBody2D

const UP = Vector2(0,-1)

var motion = Vector2()
var direction = 1
var facing_right
var hit_timer = 0

func _ready():
	$floor_check.position.x = $CollisionShape2D.shape.get_extents().x * direction

func _physics_process(delta):
	if $Area2D.dead == true:
		die()
		motion.x = 0
		motion.y = 0 
	else:
		if is_on_wall() or !$floor_check.is_colliding():
			direction *= -1
			$floor_check.position.x = $CollisionShape2D.shape.get_extents().x * direction
		
		if !$Vision.is_colliding() and !$Vision2.is_colliding():
			motion.x = 0
			motion.y = 0
			$AnimatedSprite.play("Still")
		elif hit_timer <=0:
			if $Vision.is_colliding():
				motion.x = -25
				facing_right = false
			else:
				motion.x = 25
				facing_right = true
			$AnimatedSprite.play("Walk")
			motion.y += 20
		else:
			$AnimatedSprite.play("Still")
		
		if motion.x > 0:
			$AnimatedSprite.scale.x = 1
		else:
			$AnimatedSprite.scale.x = -1
		
		
		hit_timer -= 1
		
		motion = move_and_slide(motion,UP)

func die():
	modulate = Color(1,1,1)
	$AnimatedSprite.play("Death")
	get_node("CollisionShape2D").disabled = true
	get_node("Dmg player/hitbox").disabled = true
	get_node("Area2D/CollisionShape2D").disabled = true
	yield($AnimatedSprite, "animation_finished")
	queue_free()

func was_hit():
	hit_timer = 5
	$AnimatedSprite.play("Still")
	#print("KB")
	if facing_right:
		motion.x = -20
	else:
		motion.x = 20
