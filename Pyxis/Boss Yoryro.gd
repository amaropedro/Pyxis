extends KinematicBody2D

const UP = Vector2(0,-1)
const MAXSPEED = 200
const MAXFALLSPEED = 200
const SPEED = 15
const TIMER = -70
const PROJECTILE = preload("res://YoryroP1.tscn")

onready var lazer = get_parent().get_node("lazer")
onready var player = get_parent().get_node("Player")
onready var C1 = get_parent().get_node("cealing 1")
onready var C2 = get_parent().get_node("cealing 2")
onready var Middle = get_parent().get_node("middle")
var cutscene_ended
var motion = Vector2()
var entered = true
var wall_times = 0
var shoot_cooldown = 0
var shoot_times = 0
var entered_middle = false
var ent_tiemer = 0
var lazer_timer = 0
var pre_lazer_timer = 0 
var playing = false

func _physics_process(delta):
	cutscene_ended = get_parent().get_node("boss arena").cutscene_ended
	if !$hitbox.dead and cutscene_ended:
		
		if wall_times < 2:
			lazer.get_node("AnimatedSprite").play("none")
			playing =  false
			lazer_timer = 0
			pre_lazer_timer = 0
			shoot_cooldown = 0
			shoot_times = 0
			ent_tiemer -= 1
			$feet_hitbox/CollisionShape2D.disabled = false
			$head/CollisionShape2D3.disabled = true
			$hitbox/CollisionShape2D2.disabled = false
			$hitbox/CollisionShape2D.position.y = 6
			$hitbox/CollisionShape2D.position.x = 0.5
			$CollisionShape2D.position.y = 1
			$AnimatedSprite.play("Walk")
			if $hitbox.overlaps_area(C1):
				if !entered:
					wall_times += 1
					#print(wall_times)
					motion = Vector2(0,0)
					position.x = -1292
					position.y = -85
					ent_tiemer = 0
					entered = true
					entered_middle = false
				if ent_tiemer < TIMER:
					motion.x = min(motion.x + SPEED, MAXSPEED)
					motion.y = min(motion.y+25, MAXFALLSPEED)
			if $hitbox.overlaps_area(Middle):
				if !entered_middle:
					entered_middle = true
					entered = false
					motion.y = -MAXFALLSPEED
			if $hitbox.overlaps_area(C2):
				if !entered:
					motion = Vector2(0,0)
					position.x = -1061
					position.y = -85
					ent_tiemer = 0
					entered = true
					entered_middle = false
				if ent_tiemer < TIMER:
					motion.x = max(motion.x - SPEED, -MAXSPEED)
					motion.y = min(motion.y+25, MAXFALLSPEED)
		else:
			#print(playing)
			$feet_hitbox/CollisionShape2D.disabled = true
			$head/CollisionShape2D3.disabled = false
			$hitbox/CollisionShape2D2.disabled = true
			$hitbox/CollisionShape2D.position.y = 12
			$hitbox/CollisionShape2D.position.x = -0.75
			$CollisionShape2D.position.y = 12
			if position.y < 21:
				$AnimatedSprite.play("Decend")
				motion.y = 100
			elif !playing:
				$AnimatedSprite.play("Lazer")
				playing = true
			
			if shoot_times <= 11:
				shoot_cooldown -= 1
				if shoot_cooldown < -50:
					shoot_times += 1
					shoot_cooldown = 0
					if shoot_times <= 10:
						var projec = PROJECTILE.instance()
						get_parent().add_child(projec)
						projec.position = $Position2D.global_position
			else:
				pre_lazer_timer -= 1
				get_parent().get_node("lazer2/AnimatedSprite").play("play")
				if pre_lazer_timer < -110:
					get_parent().get_node("lazer2/AnimatedSprite").play("none")
					lazer_timer -= 1
					lazer.get_node("AnimatedSprite").play("play")
					
					if lazer_timer < -80:
						lazer.get_node("AnimatedSprite").play("none")
						shoot_cooldown = 0
						wall_times = 0
						motion.y = - 100
					else:
						if lazer.overlaps_body(player):
							player.dmg()
			
		
		
		motion = move_and_slide(motion,UP)
	elif $hitbox.dead:
		death()

func death():
	get_parent().get_node("lazer2/AnimatedSprite").play("none")
	lazer.get_node("AnimatedSprite").play("none")
	$hitbox/CollisionShape2D.disabled = true
	$hitbox/CollisionShape2D2.disabled = true
	motion = Vector2(0,0)
	$AnimatedSprite.play("die")
	yield($AnimatedSprite,"animation_finished")
	get_parent().get_node("boss arena").defeated = true
	queue_free()
