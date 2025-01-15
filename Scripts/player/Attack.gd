extends State

@export var return_state : State
@export var shoryuken :String ="shoryuken"
@export var hadouken :String ="hadouken"
@export var return_animation_node :String ="idle"
@onready var timer : Timer =$Timer
@export var hadouken_attack : String ="hadouken"

@export var super_animation : String ="super"

func state_input(event:InputEvent):
	if(event.is_action_pressed("attack")):
		timer.start()
		
 
func _on_animation_tree_animation_finished(anim_name):
	if(anim_name==shoryuken):
		if(timer.is_stopped()):
			next_state = return_state
			playback.travel(return_animation_node)
	
		else: 
			playback.travel(hadouken_attack)
			
	if(anim_name==hadouken):
		next_state = return_state
		playback.travel(return_animation_node)
		#playback.travel(super_animation)
		

		
