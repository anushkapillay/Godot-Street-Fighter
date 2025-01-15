extends EnemyState

@export var bullet_node: PackedScene
var can_transition: bool = false


func enter():
	super.enter()
	animation_player.play("ranged_attack")
	await animation_player.animation_finished
	can_transition = true
 
func transition():
	if can_transition:
		can_transition = false
		get_parent().change_state("Dash")
