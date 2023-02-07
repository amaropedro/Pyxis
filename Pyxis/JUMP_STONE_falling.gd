extends AnimatedSprite

onready var player = get_parent().get_node("Player")

func _physics_process(delta):
	if get_parent().get_node("boss arena").defeated == true and player.jump_stone == false:
		if position.y != -380:
			position.y += 1
	if player.jump_stone == true:
		$Area2D/CollisionShape2D.disabled = true
