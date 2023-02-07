extends AnimatedSprite

onready var player = get_parent().get_node("Player")

func _physics_process(delta):
	if get_parent().get_node("boss arena").defeated == true and player.atk_stone == false:
		if position.y != 200:
			position.y += 1
	if player.atk_stone == true:
		$Area2D/CollisionShape2D.disabled = true
