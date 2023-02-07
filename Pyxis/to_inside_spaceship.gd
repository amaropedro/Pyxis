extends Area2D

onready var player = get_parent().get_node("Player")
var cango = false

func _ready():
	if player.atk_stone:
		cango = true

func _physics_process(delta):
	if overlaps_body(player):
		$AnimatedSprite.play("Int")
		if player.interacting and cango:
			player.canfall = false
			player.canmove = false
			player.no_animation = true
			get_parent().get_node("Argo").play("open")
			yield(get_parent().get_node("Argo"), "animation_finished")
			get_parent().get_node("Argo").play("still")
			player.no_animation = false
			player.canfall = true
			player.canmove = true
			player.position.x = -245
			player.position.y = -770
	else:
		$AnimatedSprite.play("none")
