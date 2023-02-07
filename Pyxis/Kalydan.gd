extends KinematicBody2D

const UP = Vector2(0,-1)

export (int) var direc
export (int) var speed

onready var player_feet = get_parent().get_node("Player/Area2D")
onready var start = get_parent().get_node("Kalydan Start")
onready var stop = get_parent().get_node("Kalydan Stop")
var motion = Vector2()
var starting_pos = Vector2()
var w_timer = 5
var respawn_timer = 0
var res = false

func _ready():
	starting_pos.x = position.x
	starting_pos.y = position.y
	$AnimatedSprite.scale.x = direc

func _physics_process(delta):
	
	motion.y = 0
	
	if not($"Wake 1".overlaps_area(start)):
		w_timer -= 1
		#print(w_timer)
	
	if respawn_timer < -100:
		$AnimatedSprite.play("Die")
		yield($AnimatedSprite, "animation_finished")
		position.x = starting_pos.x
		position.y = starting_pos.y
		respawn_timer = 0
		$AnimatedSprite.play("Respawn")
		res = true
		yield($AnimatedSprite, "animation_finished")
		res = false
		#print("respawn")
	
	if ($"Wake 1".overlaps_area(player_feet) or w_timer > 0) and !$"Wake 1".overlaps_area(stop):
		$AnimatedSprite.play("Walk")
		respawn_timer = 0
		if $"Wake 1".overlaps_area(player_feet):
			w_timer = 300
		motion.x = speed*direc
	else:
		if $"Wake 1".overlaps_area(player_feet) == false:
			if not($"Wake 1".overlaps_area(start)) and w_timer < 0:
				#print("AA")
				respawn_timer -= 1
		
		if !res:
			$AnimatedSprite.play("Still")
		motion.x = 0
	
	motion = move_and_slide(motion,UP)
