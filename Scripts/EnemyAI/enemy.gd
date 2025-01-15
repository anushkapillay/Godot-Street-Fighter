extends CharacterBody2D

@onready var player = get_parent().find_child("player")
@onready var sprite = $Sprite2D
@onready var progress_bar = $enemyHealth/ProgressBar
@export var maxHealth = 100
var currentHealth : int = maxHealth
signal enemy_health_changes

var speed = 300
var direction : Vector2 = Vector2.ZERO
var DEF = 0
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
 
func _ready():
	set_physics_process(false)
 
func _process(_delta):
	direction = player.position - position
	if direction.x < 0:
		sprite.flip_h = true
	else: 
		sprite.flip_h = false
 
func _physics_process(delta):
	velocity.y =0
	#if direction.x > 0:
		#velocity.x = speed
	#else:
	velocity.x = move_toward(velocity.x, 0, speed)
	#velocity = direction.normalized() * 40
	#move_and_collide(velocity * delta)
	move_and_slide()
	#take_damage()
 
func take_damage():
	maxHealth=progress_bar.value
	if maxHealth == 0:
		progress_bar.visible = false
		find_child("FiniteStateMachine").change_state("Death")
		print("death......................")
	#else:
		#find_child("FiniteStateMachine").change_state("ArmorBuff") 

func enemy():
	pass


func _on_enemy_hit_box_body_entered(body):
	if body.is_in_group("Player"):
		currentHealth -= 10
		if currentHealth == 0:
			print("enemy dies")
			take_damage()
	print("current enemy health ",currentHealth)
	enemy_health_changes.emit()
