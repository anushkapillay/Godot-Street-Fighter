extends State

@onready var player = $"../.."
@export var return_state : State
@export var defeat :String ="defeat"
@export var return_animation_node :String ="lose"
#@onready var timer : Timer =$Timer



#if player.is_alive == false:
	#

func _on_animation_tree_animation_finished(anim_name):	
	if(anim_name==defeat):
		next_state = return_state
		playback.travel(return_animation_node)
		#playback.travel(super_animation)
		

		
