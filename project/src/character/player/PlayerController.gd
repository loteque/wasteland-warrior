extends CharacterBody2D

@export var speed := 50
@export var sprite_component: CharSpriteComponent
@export var hurt_box_component: HurtBoxComponent
@export var invulnerability_component: InvulnerabilityComponent
@export var health_component: HealthComponent
@export var char_sound_component: CharSoundComponent
@export var gun_component: GunComponent
@export var xp_tracker: XpTracker

var controller_t: Resource = load("res://src/Controller.gd")
var controller: Controller
@onready var aim_origin = $AimOrigin

func _init():
	controller = controller_t.new()

# should this be in main.gd?
func _unhandled_input(event):
	if event is InputEventJoypadMotion:
		controller.type = controller.JOYPAD

	if event is InputEventKey or event is InputEventMouseMotion:
		controller.type = controller.KEYBOARD_MOUSE

func aim():
	var attack_angle = controller.aim(aim_origin)
	if is_facing_left():
		attack_angle = -attack_angle + PI
	gun_component.rotation = attack_angle

func _physics_process(_delta):
	# player actions
	
	aim()
	
	controller.move(self, speed)
	
	if is_attack_frame():
		gun_component.attack()
		
	# animations
	var motion_x = controller.get_motion_vector().x
	var motion_y = controller.get_motion_vector().y
	
	if motion_x > 0 && is_facing_left(): face_right()
	if motion_x < 0 && !is_facing_left(): face_left()
	
	if motion_x == 0 and motion_y == 0:
		sprite_component.play("idle")
	else:
		sprite_component.play("run")

#this seems like a global utility function
func is_attack_frame():
	return Engine.get_physics_frames() % gun_component.attack_interval == 0

func face_left():
	global_transform.x.x = -1


func is_facing_left():
	return global_transform.x.x == -1

func face_right():
	global_transform.x.x = 1

func collect():
	xp_tracker.collect()

func _on_health_component_died():
	set_physics_process(false)
	sprite_component.play_death()
	hurt_box_component.stop_monitoring()
	Signals.emit_signal("player_died")

func _on_hurt_box_compnent_body_entered(body:Node2D):
	if body.is_in_group(hurt_box_component.hurt_group):
		hurt_box_component.take_damage(body.damage)
		invulnerability_component.set_invulnerable(true)
		hurt_box_component.stop_monitoring()

func _on_hurt_box_compnent_took_damage(value):
	health_component.damage(value)
	char_sound_component.play_hit_sound()
	sprite_component.play_hit_flash()

func _on_invulnerability_component_invulnerability_ended():
	hurt_box_component.start_monitoring()
