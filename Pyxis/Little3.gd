extends KinematicBody2D

const UP = Vector2(0,-1)
const MAXSPEED = -175
const COOLDOWN = 80
const PROJECTILE = preload("res://Little Projectile2.tscn")

onready var player = get_parent().get_node("Player")
var motion = Vector2()
var anim = "Still"
var shoot_cooldown = 0
var move = true

func _physics_process(delta):
	if player.little_encounter3 or (player.little_encounter1 == false):
		$AnimatedSprite.play("None")
		$CollisionShape2D.disabled = true
	elif $Vision.overlaps_area(get_parent().get_node("Little Stop")) :
		print("AA")
		player.little_encounter3 = true
		$AnimatedSprite.play("None")
		get_parent().get_node("Little teleport").queue_free()
		get_parent().get_node("Little move").queue_free()
		$CollisionShape2D.disabled = true
	elif move:
		$AnimatedSprite.play(anim)
		shoot_cooldown -= 1
		
		if $Vision.overlaps_body(player):
			anim = "Walk"
			motion.x = max(motion.x - 18, MAXSPEED)
			if shoot_cooldown <= 0:
				anim = "Still"
				shoot_cooldown = COOLDOWN
				var projec = PROJECTILE.instance()
				get_parent().add_child(projec)
				projec.position = $Position2D.global_position
		else:
			anim = "Still"
		
	motion = move_and_slide(motion,UP)

