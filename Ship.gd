
extends RigidBody2D

export var FIREBALL_SCENE = preload("res://FireBall.tscn")
export var FIRE_RATE = 3
export var ROT_SPEED = 75
export var FW_SPEED = 10
export var MAX_SPEED = 300
export var BRAKE_SPEED = 2
var fireInterval = 1000 / FIRE_RATE
var lastFiredTime = OS.get_ticks_msec()
var velocity = 0

func _physics_process(delta):
	if Input.is_action_pressed("fire"):
		var currentTime = OS.get_ticks_msec()
		if (currentTime - lastFiredTime) > fireInterval:
			_shoot()
			lastFiredTime = OS.get_ticks_msec()
	if Input.is_action_pressed("ui_right"):
		rotation_degrees += ROT_SPEED * delta
	if Input.is_action_pressed("ui_left"):
		rotation_degrees -= ROT_SPEED * delta
	if Input.is_action_pressed("ui_up"):
		velocity += FW_SPEED
		if velocity > MAX_SPEED:
			velocity = MAX_SPEED
	else:
		velocity -= BRAKE_SPEED
		if velocity < 0:
			velocity = 0
	var motion = velocity * delta * Vector2(0,-1).rotated(deg2rad(rotation_degrees))
	print("velocity: ",velocity)
	set_position(get_position() + motion)
	position.x = clamp(position.x, -1024, 1024)
	position.y = clamp(position.y, -1024, 1024)
	
func _shoot():
	var firepoint = get_node("Firepoint")
	var fireball = FIREBALL_SCENE.instance()
	var rotRadiant = deg2rad(rotation_degrees)
	var actualFirepointPos = position + firepoint.position.rotated(rotRadiant)
	fireball.start_at(rotRadiant, actualFirepointPos, velocity)
	get_parent().add_child(fireball)
	
	
