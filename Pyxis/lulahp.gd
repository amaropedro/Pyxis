extends TextureProgress

onready var player = get_parent().get_parent().get_node("Player")

func _process(delta):
	value = player.lulaHP
