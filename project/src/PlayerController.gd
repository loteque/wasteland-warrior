extends KinematicBody2D

export var speed := 50
export var health := 10

var is_invincible = false
onready var iframe_timer = $IFrameTimer 
onready var sprite = $Sprite
onready var sprite_fx_animations = sprite.get_node("AnimationPlayer")


func _ready():
	$Sprite.self_modulate = Color(1, 1, 1)

func _physics_process(delta):
	var motion = Vector2.ZERO
	
	if Input.is_action_pressed("ui_up"):
		motion.y -= 1
		
	if Input.is_action_pressed("ui_down"):
		motion.y += 1
		
	if Input.is_action_pressed("ui_left"):
		motion.x -= 1
		
	if Input.is_action_pressed("ui_right"):
		motion.x += 1
		
	motion = motion.normalized() * speed
	move_and_slide(motion)

func _on_HurtBox_body_entered(body):
	if !is_invincible:
		take_damage(body.damage)
		make_temporarily_invincible()

func take_damage(amount):
	sprite_fx_animations.play("Hit Flash")
	health -= amount

func make_temporarily_invincible():
	is_invincible = true
	start_iframe_timer()

func start_iframe_timer():
	iframe_timer.start()
	
func _on_IFrameTimer_timeout():
	make_vincible()

func make_vincible():
	is_invincible = false
