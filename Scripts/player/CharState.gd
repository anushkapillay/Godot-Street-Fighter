extends Label


@export var state_machine : CharacterStateMachine


func _process(delta):
	text = "state: " + state_machine.current_state.name

func _on_timer_timeout():
	queue_free()
