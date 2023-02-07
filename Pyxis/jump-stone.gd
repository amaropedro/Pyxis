extends Area2D

onready var player = get_parent().get_parent().get_node("Player")
onready var boss_arena = get_parent().get_parent().get_node("boss arena")

func _physics_process(delta):
	if overlaps_body(player) and boss_arena.defeated == true:
		get_parent().play("none")
		boss_arena.play = false
		boss_arena.open()
		player.get_node("AnimatedSprite").play("Get Jump Stone")
		player.motion.x = 0
		player.motion.y = 0
		player.canmove = false
		player.falling = true
		player.canfall = false
		yield(player.get_node("AnimatedSprite"), "animation_finished")
		player.jump_stone = true
		player.canmove = true
		player.canfall = true
		get_parent().get_parent().get_node("tutorial").canplay = true
		get_parent().queue_free()
		
