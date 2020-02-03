extends Area2D

export var FIREBALL_SPEED = 500
var direction = Vector2(0, -1);

# Called when the node enters the scene tree for the first time.
func _ready():
	set_physics_process(true)
	
func start_at(dir, pos):
	print("called start_at:", dir, pos)
	set_rotation(dir)
	set_position(pos)
	direction = direction.rotated(dir) 

func _physics_process(delta):
	var motion = direction * delta * FIREBALL_SPEED;
	set_position(get_position() + motion)
