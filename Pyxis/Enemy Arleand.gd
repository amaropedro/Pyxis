extends KinematicBody2D

const UP = Vector2(0,-1)
const MAXSPEED = 180
const CHARGETIME = 80

onready var player = get_parent().get_node("Player")

var motion = Vector2()
var direction = 1
#var facing_right
var charging = false
var c_right
var c_left
var charge_timer = 0

func _ready():
	$floor_check.position.x = $CollisionShape2D2.shape.get_extents().x * direction

func _physics_process(delta):
	
	motion.y += 20
	
	charge_timer -= 1
	
	if charge_timer == 0:
		position.y -= 5
		
	if is_on_wall() or charge_timer <= 0:
		charging = false
		c_left = false
		c_right = false
	
	if is_on_wall() or !$floor_check.is_colliding():
		direction *= -1
		update_floor_check()
	
	if get_node("hitbox").dead == true:
		die()
	elif get_node("Vision 1").overlaps_body(player) and !c_left:
		c_right = true
		direction = 1
		update_floor_check()
		charging = true
		charge_timer = CHARGETIME
		motion.x = min(motion.x+8, MAXSPEED)
		$AnimatedSprite.play("charge")
		rotate_hitbox(true)
	elif get_node("Vision 2").overlaps_body(player) and !c_right:
		c_left = true
		direction = -1
		update_floor_check()
		charging = true
		charge_timer = CHARGETIME
		motion.x = min(motion.x-8, MAXSPEED)
		$AnimatedSprite.play("charge")
		rotate_hitbox(true)
	elif !charging:
		rotate_hitbox(false)
		motion.x = 25 * direction
		$AnimatedSprite.play("Walk")
	
	if direction > 0:
		$AnimatedSprite.scale.x = 1
	else:
		$AnimatedSprite.scale.x = -1
	
	motion = move_and_slide(motion,UP)

func die():
	modulate = Color(1,1,1)
	motion.y = 0
	motion.x = 0
	$AnimatedSprite.play("Death")
	get_node("hitbox/dmg_player").disabled = true
	get_node("CollisionShape2D2").disabled = true
	yield($AnimatedSprite, "animation_finished")
	queue_free()

func KB():
	#$AnimatedSprite.play("Still")
	if direction > 0:
		motion.x = -200
	else:
		motion.x = 200

func update_floor_check():
	$floor_check.position.x = $CollisionShape2D2.shape.get_extents().x * direction

func rotate_hitbox(var horizontal):
	if horizontal:
		get_node("hitbox/dmg_player").rotation_degrees = 90
		get_node("CollisionShape2D2").rotation_degrees = 90
	else:
		get_node("hitbox/dmg_player").rotation_degrees = 0
		get_node("CollisionShape2D2").rotation_degrees = 0

