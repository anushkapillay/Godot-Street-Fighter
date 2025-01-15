extends State

class_name AirState


@export var landing_state : State
@export var double_jump_velocity : float= -400.0
@export var double_jump_animation : String = "double_jump_kick"
#var next_state : State
@export var landing_animation : String = "landing"
var has_doubled_jumped = false

func state_process(delta):
	if(character.is_on_floor()):
		next_state = landing_state

	
func state_input(event:InputEvent):
	if(event.is_action_pressed("jump") && not has_doubled_jumped):
		double_jump()
	
func on_exit():
	if(next_state==landing_state):
		playback.travel(landing_animation)
		has_doubled_jumped = false

func double_jump():
	character.velocity.y = double_jump_velocity
	playback.travel(double_jump_animation)
	#animated_sprite.play("double_jump_kick")
	has_doubled_jumped = true
	
	
