extends KinematicBody2D

const UP = Vector2(0,-1)
const FALLSPEED = 250
const GRAVITY = 20
const MAXFALLSPEED = 180
const COOLDOWN = 375
const STUN = 150
const PATROL_SIZE = 90
const SPEED = 35
const PROJECTILE1 = preload("res://Jewelio P1.tscn")
const PROJECTILE2 = preload("res://Jewelio P2.tscn")
const PROJECTILE3 = preload("res://Jewelio P3.tscn")
const PROJECTILE4 = preload("res://Jewelio P4.tscn")
const PROJECTILE5 = preload("res://Jewelio P5.tscn")
const PROJECTILE6 = preload("res://Jewelio P6.tscn")
const PROJECTILE7 = preload("res://Jewelio P7.tscn")

var direction = -1
var motion = Vector2()
var starting_location
var stun_timer = 0
var can_stomp = false
var spawn = true
var no_hit_timer = 0
var aux = true

onready var player = get_parent().get_node("Player")
onready var boss_arena = get_parent().get_node("boss arena")

func _ready():
	starting_location = position.x



func _physics_process(delta):
	
	if player.jump_stone:
		boss_arena.defeated = true
		get_parent().get_node("boss arena").open()
		queue_free()
	
	if $"dmg hitbox".dead:
		die()
	else:
		no_hit_timer += 1
		stun_timer -= 1
		
		if no_hit_timer > 400 and boss_arena.overlaps_body(player):
			projec()
			no_hit_timer = 0
		
		motion.y = min(motion.y+GRAVITY, MAXFALLSPEED)
		
		if $"dmg hitbox".atk:
			if stun_timer < 0 and aux:
				aux = false
				motion.x = 0
				$AnimatedSprite.play("Atk")
				yield($AnimatedSprite, "animation_finished")
				$"dmg hitbox".atk = false
				$"dmg hitbox".armor = 3
				projectiles()
		elif stun_timer < 0:
			if $"dmg hitbox".i_frames < 0:
					$AnimatedSprite.play("Walk")
			else:
				$AnimatedSprite.play("Dmg")
				
			if motion.x < SPEED:
				motion.x = SPEED*direction
			
			if position.x >= starting_location + PATROL_SIZE:
				motion.x = -SPEED
				direction = -1
			
			elif position.x <= starting_location - PATROL_SIZE:
				motion.x = SPEED
				direction = 1
			
		
		
		if !is_on_floor() and !spawn:
			can_stomp = true
		elif can_stomp and is_on_floor():
			var P6 = PROJECTILE6.instance()
			var P7 = PROJECTILE7.instance()
			
			get_parent().add_child(P6)
			P6.position = $P6.global_position
			
			get_parent().add_child(P7)
			P7.position = $P7.global_position
			
			$"dmg hitbox".armor = 2
			can_stomp = false
			aux = true
		
		if stun_timer > 0 and stun_timer < 50:
			$"dmg hitbox".armor = 2
		
		if stun_timer == 0:
			s_jump()
		
		move_and_slide(motion, UP)


func projectiles():
	var P1 = PROJECTILE1.instance()
	var P2 = PROJECTILE2.instance()
	var P3 = PROJECTILE3.instance()
	var P4 = PROJECTILE4.instance()
	var P5 = PROJECTILE5.instance()
	
	print("A")
	
	get_parent().add_child(P1)
	P1.position = $P1.global_position
	
	get_parent().add_child(P2)
	P2.position = $P2.global_position
	
	get_parent().add_child(P3)
	P3.position = $P3.global_position
	
	get_parent().add_child(P4)
	P4.position = $P4.global_position
	
	get_parent().add_child(P5)
	P5.position = $P5.global_position
	
	$AnimatedSprite.play("Stun")
	stun_timer = STUN

func projec():
	var P4 = PROJECTILE4.instance()
	var P5 = PROJECTILE5.instance()
	
	get_parent().add_child(P4)
	P4.position = $P4.global_position
	
	get_parent().add_child(P5)
	P5.position = $P5.global_position

func s_jump():
	spawn = false
	motion.y = -600

func die():
	get_node("dmg hitbox/Body").disabled = true
	get_node("dmg hitbox/Ore Horns").disabled = true
	get_node("Arms/CollisionShape2D").disabled = true
	get_node("Arms/CollisionShape2D2").disabled = true
	get_node("hitbox").disabled = true
	modulate = Color(1,1,1)
	motion.y = 0
	motion.x = 0
	$AnimatedSprite.play("Death")
	yield($AnimatedSprite, "animation_finished")
	boss_arena.defeated = true
	queue_free()

