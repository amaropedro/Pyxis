extends KinematicBody2D

const R_COOLDOWN = 80
const C_COOLDOWN = 40

onready var player = get_parent().get_node("Player")

var crumble = false
var crumble_timer = 40
var reform_timer = 0
var size

func _ready():
	size = $CollisionShape2D.shape.extents.x

func _physics_process(delta):
	
	reform_timer -= 1
	
	if crumble:
		$AnimatedSprite.play("Crumble")
		if $CollisionShape2D.shape.extents.x > 0:
			$CollisionShape2D.shape.extents.x -= 0.8
		crumble_timer -= 1
	
	if $"feet_touch".overlaps_area(player.get_node("Area2D")):
		crumble = true
		reform_timer = R_COOLDOWN
	elif reform_timer < 0:
		crumble = false
		crumble_timer = C_COOLDOWN
		$AnimatedSprite.play("Still")
		$CollisionShape2D.shape.extents.x = size
		
	if crumble_timer <= 0:
		$AnimatedSprite.play("none")
		$CollisionShape2D.disabled = true
		$feet_touch/CollisionShape2D.disabled = true
	else:
		$CollisionShape2D.disabled = false
		$feet_touch/CollisionShape2D.disabled = false
