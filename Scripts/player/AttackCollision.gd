extends Area2D


@export var damage : float =20

func _ready():
	monitoring = false
	
func _on_body_entered(body):
	#body.take_damage()
	print(body.name)

var direction = Vector2.RIGHT
var speed = 300
 
func _physics_process(delta):
	position += direction * speed * delta
 #
func _on_visible_on_screen_notifier_2d_2_screen_exited():
	queue_free()
