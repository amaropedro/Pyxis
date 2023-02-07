extends KinematicBody2D

const UP = Vector2(0,-1)
const GRAVITY = 20
const MAXFALLSPEED = 400
const MAXSPEED = 180
const JUMPFORCE = 350
const ACCEL = 10
const IFRAMES = 100
const COOLDOWN = 35
const PROJECTILE = preload("res://Player Projectile.tscn")

var canmove = true
var FALLSPEED = MAXFALLSPEED
var facing_right = true
var motion = Vector2()
var last_ground = Vector2()
var itimer = 0
var invencible = false
var kb = true
var atk = false
var atk_cooldown = 0
var atk_stone = false
var jump_stone = false
var shoot_stone = false
var falling = false
var canfall = true
var interacting = false
var last_checkpoint
var last_pos = Vector2()
var checkpoint_pos = Vector2()
var no_animation = false
var checkpoint_freed = false
var little_encounter1 = false
var little_encounter2 = false
var little_encounter3 = false
var little_encounter4 = false
var life_up1 = false
var life_up2 = false
var life_up3 = false
var life_up4 = false
var sjump_charge_timer = 0
var already_playing = false

var lulaHP = 25
var HP = 3

export (Script) var save_stats_class

func _ready():
	$sword/swrod_hitbox.disabled = true
	var dir = Directory.new()
	if not dir.dir_exists("user://saves/"):
		dir.make_dir_recursive("user://saves/")
	
	load_save()

func load_save():
	var world_save = load("user://saves/save_01.tres");
	if world_save == null:
		print("erro, save não existe, mantendo valores padrões")
		HP = 3
		lulaHP = 35
		atk_stone = false
		jump_stone = false
		shoot_stone = false
		checkpoint_freed = false
		little_encounter1 = false
		little_encounter2 = false
		little_encounter3 = false
		little_encounter4 = false
		life_up1 = false
		life_up2 = false
		life_up3 = false
		life_up4 = false
		last_checkpoint = "res://World.tscn"
		last_pos = Vector2(-304, 296)
		checkpoint_pos = Vector2(-304, 296)
		print(" posx: " + str(last_pos.x) +" posy: " + str(last_pos.y))
	else:
		HP = world_save.HP
		lulaHP = world_save.lula_HP
		checkpoint_freed = world_save.checkpoint_freed
		little_encounter1 = world_save.l_1
		little_encounter2 = world_save.l_2
		little_encounter3 = world_save.l_3
		little_encounter4 = world_save.l_4
		life_up1 = world_save.life_1
		life_up2 = world_save.life_2
		life_up3 = world_save.life_3
		life_up4 = world_save.life_4
		atk_stone = world_save.ATK_stone
		jump_stone = world_save.SJUMP_stone
		shoot_stone = world_save.SHOOT_stone
		last_checkpoint = world_save.last_checkpoint
		checkpoint_pos.y = world_save.checkpoint_position.y
		checkpoint_pos.x = world_save.checkpoint_position.x
		last_pos.y = world_save.lv_warp.y
		last_pos.x = world_save.lv_warp.x
		position.y = last_pos.y
		position.x = last_pos.x
		print("save encontrado. carregando valores: "+str(HP) + " checkpoint: " +str(last_checkpoint) +" posx: " + str(last_pos.x) +" posy: " + str(last_pos.y))
	update_hud()

func save_save(var b_atk, var b_jump, var b_shoot, var pos_x, var pos_y):
	print("Salvando os dados no arquivo.  HP atual: "+str(HP) +" posx: " + str(pos_x) + " posy: " +str(pos_y))
	var new_save = save_stats_class.new()
	new_save.HP = HP
	new_save.lula_HP = lulaHP
	new_save.checkpoint_freed = checkpoint_freed
	new_save.l_1 = little_encounter1
	new_save.l_2 = little_encounter2
	new_save.l_3 = little_encounter3
	new_save.l_4 = little_encounter4
	new_save.life_1 = life_up1
	new_save.life_2 = life_up2
	new_save.life_3 = life_up3
	new_save.life_4 = life_up4
	new_save.ATK_stone = b_atk
	new_save.SJUMP_stone = b_jump
	new_save.SHOOT_stone = b_shoot
	
	#print(last_checkpoint)
	new_save.last_checkpoint = last_checkpoint
	new_save.checkpoint_position.x = checkpoint_pos.x
	new_save.checkpoint_position.y = checkpoint_pos.y
	new_save.lv_warp.x = pos_x
	new_save.lv_warp.y = pos_y
	ResourceSaver.save("user://saves/save_01.tres", new_save)

func _physics_process(delta):
	
	var friction = false
	
	if canfall:
		motion.y = min(motion.y+GRAVITY, FALLSPEED)

	if facing_right == true:
		$AnimatedSprite.scale.x = 1.3
		$sword/swrod_hitbox.position.x = 11
	else:
		$AnimatedSprite.scale.x = -1.3
		$sword/swrod_hitbox.position.x = -14
	
	if Input.is_action_just_released("interact") and canmove:
		interacting = true
		#print(position.x)
		#print(position.y)
	else:
		interacting = false
	
	if Input.is_action_pressed("right") and canmove:
		motion.x = min(motion.x+ACCEL, MAXSPEED)
		facing_right = true
		if !atk and !falling and !already_playing:
			$AnimatedSprite.play("Run")
		$floor_check.position.x = $CollisionShape2D.shape.get_extents().x
	elif Input.is_action_pressed("left") and canmove:
		motion.x = max(motion.x-ACCEL, -MAXSPEED)
		facing_right = false
		if !atk and !falling and !already_playing:
			$AnimatedSprite.play("Run")
		$floor_check.position.x = -$CollisionShape2D.shape.get_extents().x
	elif !atk and !falling and !no_animation and !already_playing:
		friction = true
		$AnimatedSprite.play("Idle")
	
	if atk_stone == true and canmove:
		if Input.is_action_just_released("attack") and atk_cooldown <= 0 and !no_animation:
			if is_on_floor():
				motion.x = 0
			$AnimatedSprite.play("Atk")
			atk = true
			$sword/swrod_hitbox.disabled = false
			atk_cooldown = COOLDOWN
			yield($AnimatedSprite, "animation_finished")
			atk = false
			falling = false
			$sword/swrod_hitbox.disabled = true
			
	if shoot_stone == true and canmove: 
		if Input.is_action_just_released("shoot") and atk_cooldown <= 0 and !no_animation:
			$AnimatedSprite.play("Shoot")
			atk = true
			atk_cooldown = COOLDOWN
			var projec = PROJECTILE.instance()
			if facing_right:
				$Position2D.position.x = 11
				projec.set_direction(1)
			else:
				$Position2D.position.x = -15
				projec.set_direction(-1)
			get_parent().add_child(projec)
			projec.position = $Position2D.global_position
			yield($AnimatedSprite, "animation_finished")
			atk = false
			falling = false
	
	if is_on_floor():
		falling = false
		if $floor_check.is_colliding():
			last_ground.x = global_position.x
			last_ground.y = global_position.y
		
		if Input.is_action_just_pressed("jump") and canmove:
			motion.y = -JUMPFORCE
		elif jump_stone:
			if Input.is_action_pressed("super_jump") and !no_animation:
				canmove = false
				motion.x = 0
				sjump_charge_timer += 1
				if !already_playing:
					$AnimatedSprite.play("S_jump")
					already_playing = true
			if Input.is_action_just_released("super_jump"):
				canmove = true
				already_playing = false
				if sjump_charge_timer > 70:
					sjump_charge_timer = 0
					motion.y = - (2*JUMPFORCE)
		if friction:
			motion.x = lerp(motion.x, 0, 0.3)
	else:
		if motion.y < 0 and !atk:
			$AnimatedSprite.play("Jump")
		if motion.y >0 and !atk and !falling:
			canmove = true
			already_playing = false
			$AnimatedSprite.play("Fall")
			falling = true
			#print("ENNNNNNTROUUUUUUAAAAAAAAAAAAA")
		if !friction:
			motion.x = lerp(motion.x, 0, 0.05)
			
		if Input.is_action_pressed("slow_fall"):
			FALLSPEED = 125
		else:
			FALLSPEED = MAXFALLSPEED
	
	if invencible == true:
		itimer -= 1
		self.modulate.a = 0 if Engine.get_frames_drawn() % 2 == 0 else 1.0

	if itimer <= 0:
		invencible = false
		self.modulate.a = 1
	
	atk_cooldown -= 1
	
	motion = move_and_slide(motion,UP)

func dmg():
	if (not invencible):
		#print("recebendo dano")
		if (HP > 1):
			#caso HP seja maior que 0, diminui o HD, aplica knockback, deixa invencivel e atualiza o hud
			HP = HP-1
			knockback()
			invencible = true
			itimer = IFRAMES
			update_hud()
		else:
			#caso hp seja menor ou igual a 0, chama a função death
			death()

func update_hud():
	# pega todos os corações dentro do HUD/Panel (como filhos)
	var hearts = get_parent().get_node("HUD").get_node("Panel").get_children()
	# passa por todos os corações e aplica a cor  = 0
	for heart in hearts:
		heart.modulate = Color(0, 0, 0)
		if not(life_up1 and life_up2 and life_up3 and life_up4):
			get_parent().get_node("HUD").get_node("Panel").get_node("HP 6").modulate = Color (0,0,0,0)
	# só passa pelos corações referentes ao HP. por exemplo: hp é 3, vai dos corações 0 ate 3 e aplica cor branca
	for i in range(HP):
		hearts[i].modulate = Color(1,1,1)

func knockback():
	if kb:
		if motion.x>=0:
			motion.x = -200
		else:
			motion.x = 200
		motion.y =-170

func death():
	#$AnimatedSprite.play("Death")
	#ao morrer, aplica o HP de volta a 3 e salva o arquivo
	if lulaHP > 0:
		lulaHP = 25
	if last_checkpoint == "res://World.tscn":
		HP = 3
	else:
		if life_up1 and life_up2 and life_up3 and life_up4:
			HP = 6
		else:
			HP = 5
	save_save(atk_stone, jump_stone, shoot_stone, checkpoint_pos.x, checkpoint_pos.y)
	print(last_checkpoint)
	get_tree().change_scene(last_checkpoint)

