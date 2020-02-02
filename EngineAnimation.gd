extends AnimationTree

enum EngineStates {IDLE, ON}
var playback : AnimationNodeStateMachinePlayback
var currentState

# Called when the node enters the scene tree for the first time.
func _ready():
	playback = get("parameters/playback")
	playback.start("engine-stop-idle")
	active = true
	currentState = EngineStates.IDLE
	
	
func _process(delta):
	if Input.is_action_pressed("ui_up"):
		if(currentState == EngineStates.IDLE):
			playback.travel("engine-start")
			currentState = EngineStates.ON	
	else:
		if(currentState == EngineStates.ON):
			playback.travel("engine-ramp-down")
			currentState = EngineStates.IDLE
			
		
	

