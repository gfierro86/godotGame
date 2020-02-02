
extends RigidBody2D

export var FIREBALL_SCENE = preload("res://FireBall.tscn")
export var FIRE_RATE = 3
export var ROT_SPEED = 100
export var FW_SPEED = 100
var fireInterval = 1000 / FIRE_RATE
var lastFiredTime = OS.get_ticks_msec()

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
		position += (FW_SPEED * delta) * Vector2(0,-1).rotated(deg2rad(rotation_degrees))
	
func _shoot():
	var firepoint = get_node("Firepoint")
	var fireball = FIREBALL_SCENE.instance()
	var rotRadiant = deg2rad(rotation_degrees)
	var actualFirepointPos = position + firepoint.position.rotated(rotRadiant)
	fireball.start_at(rotRadiant, actualFirepointPos)
	get_parent().add_child(fireball)
	
	
