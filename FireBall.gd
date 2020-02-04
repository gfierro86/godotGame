extends Area2D

export var FIREBALL_SPEED = 500
var direction = Vector2(0, -1)
var actualSpeed = FIREBALL_SPEED

# Called when the node enters the scene tree for the first time.
func _ready():
	set_physics_process(true)
	
func start_at(dir, pos, shipSpeed):
	set_rotation(dir)
	set_position(pos)
	direction = direction.rotated(dir) 
	actualSpeed += shipSpeed

func _physics_process(delta):
	print("Fireball velocity:", actualSpeed)
	var motion = direction * (delta * actualSpeed);
	set_position(get_position() + motion)
