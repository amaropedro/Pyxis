extends KinematicBody2D

const UP = Vector2(0,-1)
const SPEED = 35
const PATROL_SIZE = 90
const COOLDOWN = 80
const PROJECTILE = preload("res://Enemy Projectile.tscn")

onready var player = get_parent().get_node("Player")

var starting_heigh
var starting_location
var motion = Vector2()
var direction = 1
var shoot_cooldown = 0

func _ready():
	starting_location = position.x
	starting_heigh = position.y
	motion.x = SPEED

func _physics_process(delta):
	
	shoot_cooldown -= 1
	
	if position.y != starting_heigh:
		position.y = starting_heigh
	motion.y = 0
	
	if motion.x < SPEED and "dead":
		motion.x = SPEED*direction
	
	if $vitu_hitbox.dead == true:
		die()
	else:
		$AnimatedSprite.play("Fly")
	
	if position.x >= starting_location + PATROL_SIZE:
		direction = -1 
		motion.x = -SPEED
		$AnimatedSprite.scale.x = -1
	elif position.x <= starting_location - PATROL_SIZE:
		direction = 1
		motion.x = SPEED
		$AnimatedSprite.scale.x = 1
	
	
	if $vision.overlaps_body(player) and shoot_cooldown <= 0 and ($vitu_hitbox.dead == false):
		#self.modulate = Color(1,1,1) if Engine.get_frames_drawn() % 2 == 0 else Color(5,5,5)
		self.modulate.a = 0 if Engine.get_frames_drawn() % 2 == 0 else 1.0
		shoot_cooldown = COOLDOWN
		var projec = PROJECTILE.instance()
		get_parent().add_child(projec)
		projec.position = $Position2D.global_position
	else:
		self.modulate = Color(1,1,1)
		
	motion = move_and_slide(motion,UP)

func die():
	motion.x = 0
	motion.y = 0
	$AnimatedSprite.play("Death")
	get_node("vitu_hitbox/CollisionShape2D").disabled = true
	get_node("CollisionShape2D").disabled = true
	yield($AnimatedSprite, "animation_finished")
	queue_free()
