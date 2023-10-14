extends CharacterBody2D

@export var speed := 50
@export var sprite_component: CharSpriteComponent
@export var hurt_box_component: HurtBoxComponent
@export var invulnerability_component: InvulnerabilityComponent
@export var health_component: HealthComponent
@export var char_sound_component: CharSoundComponent
@export var gun_component: GunComponent

func _ready():
	gun_component.player = self

func _physics_process(_delta):
	
	if is_attack_frame():
		gun_component.attack()
	
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

#this seems like a global utility function
func is_attack_frame():
	return Engine.get_physics_frames() % gun_component.attack_interval == 0

func face_left():
	global_transform.x.x = -1

func is_facing_left():
	return global_transform.x.x == -1

func face_right():
	global_transform.x.x = 1

func rotate_180(radians: float):
	return radians + PI

func _on_health_component_died():
	set_physics_process(false)
	ComponentUtils.set_component_property(hurt_box_component, "monitoring", false)
	Signals.emit_signal("player_died")

func _on_hurt_box_compnent_body_entered(body:Node2D):
	if body.is_in_group(hurt_box_component.hurt_group):
		hurt_box_component.took_damage.emit(body.damage)
		ComponentUtils.set_component_property(invulnerability_component, "is_invulnerable", true, false)
		ComponentUtils.set_component_property(hurt_box_component, "monitoring", false)

func _on_hurt_box_compnent_took_damage(value):
	health_component.damage(value)
	char_sound_component.hit_sound.play()
	sprite_component.fx.play("hit_flash")


func _on_invulnerability_component_invulnerability_ended():
	ComponentUtils.set_component_property(hurt_box_component, "monitoring", true)
