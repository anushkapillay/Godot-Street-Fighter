extends Node


class_name Damage
#signal on_hit(node :Node, damage_taken :int)
@export var health : float = 20
#@onready var timer : Timer =$Timer

func hit(damage :int):
	health -=damage
	
	#emit_signal("on_hit",get_parent(),damage)
	
	if(health <=0):
		get_parent().queue_free()
