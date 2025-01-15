extends State


class_name DuckState

@export var duck_animation_name : String = "duck"
@export var ground_state : State
#@export var landing_state : State

func _on_animation_tree_animation_finished(anim_name):
	if(anim_name == duck_animation_name):
		next_state = ground_state

