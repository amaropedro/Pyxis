extends Area2D

onready var player = get_parent().get_node("Player")
export(String, FILE, "*.tscn") var next_level
export(Vector2) var lv_position

func _physics_process(delta):
	if overlaps_body(player):
		get_tree().change_scene(next_level)
		get_parent().get_node("Player").save_save(player.atk_stone, player.jump_stone, player.shoot_stone, lv_position.x, lv_position.y)
