extends State


class_name DuckState

@export var duck_animation_name : String = "duck-block"
@export var ground_state : State
@export var return_animation_node :String ="idle"
#@onready var timer : Timer 

func _on_animation_tree_animation_finished(anim_name):
	if(anim_name == duck_animation_name):
		await get_tree().create_timer(0.5).timeout
		next_state = ground_state
		playback.travel(return_animation_node)
