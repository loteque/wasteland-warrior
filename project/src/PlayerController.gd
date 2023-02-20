extends KinematicBody2D

export var speed := 50

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
