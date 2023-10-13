extends CharacterBody2D

@export var speed := 50
@export var attack_interval := 30
@export var projectile_speed := 100
@export var sprite_component: CharSpriteComponent
@export var projectile_pool: ObjectPool
@export var hurt_box_component: HurtBoxComponent
@export var invulnerability_component: InvulnerabilityComponent

@onready var projectile_start = $ProjectileStart
@onready var projectile_target = $ProjectileTarget

func _physics_process(_delta):
	
	if is_attack_frame():
		attack()
	
	var motion = Vector2.ZERO
	
	if Input.is_action_pressed("ui_up"):
		motion.y -= 1

	if Input.is_action_pressed("ui_down"):
		motion.y += 1
		
	if Input.is_action_pressed("ui_left"):
		motion.x -= 1
		face_left()

	if Input.is_action_pressed("ui_right"):
		motion.x += 1
		face_right()

	if motion.x == 0 and motion.y == 0:
		sprite_component.play("idle")

	else:
		sprite_component.play("run")

	motion = motion.normalized() * speed
	set_velocity(motion)
	move_and_slide()

func is_attack_frame():
	return Engine.get_physics_frames() % attack_interval == 0

func face_left():
	global_transform.x.x = -1

func is_facing_left():
	return global_transform.x.x == -1

func face_right():
	global_transform.x.x = 1

func rotate_180(radians: float):
	return radians + PI

func attack():
	var bullet = projectile_pool.get_object()
	bullet.visible = true
	var facing_angle = projectile_start.get_angle_to(projectile_target.global_position)
	if is_facing_left():
		facing_angle = rotate_180(facing_angle)
	
	bullet.update(projectile_speed, facing_angle)
	bullet.global_position = projectile_start.global_position
	Signals.emit_signal("projectile_shot")

func _on_health_component_died():
	set_physics_process(false)
	print(ComponentUtils.set_component_property(hurt_box_component, "monitoring", false))
	Signals.emit_signal("player_died")

func _on_hurt_box_compnent_body_entered(body:Node2D):
		if body.is_in_group("CanHurtPlayer"):
			hurt_box_component.took_damage.emit(body.damage)
			print(ComponentUtils.set_component_property(invulnerability_component, "is_invulnerable", true, false))
			print(ComponentUtils.set_component_property(hurt_box_component, "monitoring", false))

func _on_hurt_box_compnent_took_damage(_value):
	sprite_component.fx.play("hit_flash")

func _on_invulnerability_component_invulnerability_ended():
	print(ComponentUtils.set_component_property(hurt_box_component, "monitoring", true))
