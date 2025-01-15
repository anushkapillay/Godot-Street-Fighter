extends CharacterBody2D


@export var speed : float = 300.0
var enemy_in_range =false
var enemy_attack_cooldown =  true
var is_player_alive = true
var DEF = 0
signal player_signal
@onready var sprite : Sprite2D  = $Sprite2D
@onready var animation_tree : AnimationTree = $AnimationTree
#@onready var animation_player : AnimationPlayer = $AnimationPlayer
@onready var state_machine : CharacterStateMachine = $CharacterStateMachine
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var has_double_jumped: bool = false
var animation_locked: bool = false
var direction : Vector2 = Vector2.ZERO
var was_in_air : bool = false
@onready var progress_bar = $playerhealth/ProgressBar
var is_hurt : bool = false

@export var maxHealth = 100
var currentHealth : int = maxHealth
signal player_health_changes

func _ready():
	animation_tree.active = true


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
		was_in_air = true
	else:
		#double_jump_velocity = false #whenever player touches the ground player hasnt jumped 
		if was_in_air == true:
			land()
		was_in_air = false

			
	
	if Input.is_action_pressed("ui_down"):
		if not is_on_floor():
			animation_locked = true
		else:
			duck()
			await get_tree().create_timer(0.5).timeout
			animation_locked = false
			
			
			#animated_sprite.play("idle")

	direction = Input.get_vector("ui_left", "ui_right","ui_up","ui_down")
	
	if direction.x !=0 && state_machine.if_can_move(): #&& sprite.animation !="jump_end":
		velocity.x = direction.x * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)

	
		#self.queue_free()
		
		
	move_and_slide()
	enemy_attack()
	update_animation_parameters()
	update_facing_direction()


		
	
func update_facing_direction():
	if direction.x >0:
		#animated_sprite.flip_h = false
		sprite.flip_h = false
	elif direction.x < 0:
		#animated_sprite.flip_h = true
		sprite.flip_h = true

func update_animation_parameters():
	animation_tree.set("parameters/idle/blend_position",direction.x)

	
func land():
	#animated_sprite.play("jump_end")
	animation_locked = true

func duck():
	#animated_sprite.play("duck")
	animation_locked = true

	

func _on_player_attack_area_body_entered(body):
	if body.has_method("enemy"):
		enemy_in_range = true		

func player():
	pass

func _on_player_attack_area_body_exited(body):
	if body.has_method("enemy"):
		enemy_in_range = false
		
func enemy_attack():
	if enemy_in_range && enemy_attack_cooldown==true:
		enemy_attack_cooldown = false
		$AttackCooldown.start()
		print("health")
		

func _on_attack_cooldown_timeout():
	enemy_attack_cooldown = true


func _on_player_signal():
	pass # Replace with function body.
	

func _on_hit_box_body_entered(body):
	if body.is_in_group("Enemy"):
		currentHealth -= 10
		if currentHealth == 0:
			currentHealth = maxHealth
			print("player dies")

	print("current player health ",currentHealth)
	player_health_changes.emit()
