extends KinematicBody2D

const UP = Vector2(0,-1)
const FALLSPEED = 250
const GRAVITY = 20
const COOLDOWN = 375
const STUN = 120

var dmg_timer = 0
var last_direction = 1
var defeated = false
var HP = 5
var motion = Vector2()
var direction
var timer = 0
var s_timer = 0
var stunned = false
onready var player = get_parent().get_node("Player")

func _ready():
	if player.atk_stone == true:
		defeated = true
		get_parent().get_node("boss arena").open()
		queue_free()

func _physics_process(delta):
	if defeated == false:
		motion.y = min(motion.y+GRAVITY, FALLSPEED)
		
		if player.position.x < position.x:
			direction = -1
		else:
			direction = 1
		
		if get_parent().get_node("boss arena").overlaps_player and is_on_floor():
			motion.x = 50 * direction
			if is_on_floor() and !stunned and dmg_timer <= 0:
				$AnimatedSprite.play("Walk")
		else:
			motion.x = 0
			$AnimatedSprite.play("Idle")
		
		if ( $ATK_Range.is_colliding() or $ATK_Range2.is_colliding() ) and timer <= 0:
			rotate_hitbox()
			timer = COOLDOWN
			motion.y = - 425
			last_direction = direction
			#print("STUNADO")
			stunned = true
		
		if !is_on_floor():
			if motion.y < 0:
				$AnimatedSprite.play("Jump")
			if motion.y > 0 and !is_on_floor():
				$AnimatedSprite.play("Fall")
			if (position.x <= player.position.x + 1) and (position.x >= player.position.x - 1):
				motion.x = 1 * last_direction
			else:
				motion.x = 150 * last_direction
		
		
		if stunned == true and is_on_floor() and s_timer < 0 and dmg_timer <= 0:
			s_timer = STUN
		
		if s_timer > 0:
			$take_dmg/CollisionShape2D.disabled = false
			if is_on_floor():
				if get_node("take_dmg").dmg:
					s_timer = -1
					stunned = false
					dmg_timer = 20
					get_node("take_dmg").dmg = false
				else:
					$AnimatedSprite.play("Stun")
				$AnimatedSprite.scale.x = 2.386*(-last_direction)
				motion.x = 0
				#print(".......stunnado......")
		elif dmg_timer <= 0:
			default_hitbox()
			#print("livre")
			stunned = false
		
		timer -= 1
		s_timer -= 1
		dmg_timer -= 1
		
		if dmg_timer > 0:
			#print(".......dano......")
			modulate = Color(2,2,2)
			$AnimatedSprite.play("Dmg")
		else:
			modulate = Color(1,1,1)
			
		if HP <= 0:
			death()
		
		if motion.x > 0:
			$AnimatedSprite.scale.x = 2.386
		else:
			$AnimatedSprite.scale.x = -2.386
		
		motion = move_and_slide(motion,UP)

func death():
	modulate = Color(1,1,1)
	defeated = true
	player.canmove = false
	get_parent().get_node("boss arena").defeated = true
	$"Dmg player/dmg_hitbox".disabled = true
	$"take_dmg/CollisionShape2D".disabled = true
	$AnimatedSprite.play("Death")
	yield($AnimatedSprite, "animation_finished")
	player.canmove = true
	queue_free()
	
	#print("MORREU!")

func rotate_hitbox():
	$hitbox.rotation_degrees = 90
	$hitbox.shape.radius = 16.0
	$hitbox.position.y = -29
	$"Dmg player/dmg_hitbox".rotation_degrees = 90
	$"Dmg player/dmg_hitbox".shape.radius = 9.0
	$"Dmg player/dmg_hitbox".shape.height = 60
	$"Dmg player/dmg_hitbox".position.y = -20

func default_hitbox():
	$take_dmg/CollisionShape2D.disabled = true
	$hitbox.rotation_degrees = 0
	$hitbox.shape.radius = 25.0
	$hitbox.position.y = -24
	$"Dmg player/dmg_hitbox".rotation_degrees = 0
	$"Dmg player/dmg_hitbox".shape.radius = 27.0
	$"Dmg player/dmg_hitbox".shape.height = 16
	$"Dmg player/dmg_hitbox".position.y = -25

