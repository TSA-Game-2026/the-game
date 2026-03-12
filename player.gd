class_name Player
extends CharacterBody2D


const SPEED = 500
const ACCELERATION = 2500
const JUMP_STRENGTH = 1500


func _ready() -> void:
	pass


func _physics_process(delta: float) -> void:
	var direction = Input.get_axis("move_left", "move_right")
	
	velocity.x = move_toward(velocity.x, direction * SPEED, delta * ACCELERATION)
	
	if !is_on_floor():
		velocity += get_gravity()
	elif Input.is_action_just_pressed("move_up"):
		velocity.y -= JUMP_STRENGTH
	
	move_and_slide()
