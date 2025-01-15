extends State


class_name GroundState

@export var jump_velocity : float= -400.0
@export var air_state: State
@export var jump_animation : String = "jump"
@export var duck_state :State
@export var duck_animation : String = "duck-block"
var ground_state :State
@export var attack_state = State
@export var attack_node ="shoryuken" 


func state_process(delta):
	if(!character.is_on_floor()):
		next_state = air_state
 
func state_input(event : InputEvent):
	if(event.is_action_pressed("jump")):
		jump()
	if(event.is_action_pressed("ui_down")):
		duck()

	if(event.is_action_pressed("attack")):
		attack()
	

func on_exit():
	if(next_state==duck_state):
		playback.travel(duck_animation)
			
func jump():
	character.velocity.y = jump_velocity
	next_state = air_state
	playback.travel(jump_animation)

func duck():
	next_state = duck_state
	playback.travel(duck_animation)

func attack():
	next_state = attack_state
	playback.travel(attack_node)

	
