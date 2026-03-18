class_name Player
extends CharacterBody2D


const SPEED := 400.0
const ACCELERATION := 2500.0
const JUMP_STRENGTH := 1200.0

var normal_mask = 0b00000011 # dont fall through platforms
var fall_mask   = 0b00000001 # do fall through platforms

var damage_taken = 0


func _ready() -> void:
	pass


func _physics_process(delta: float) -> void:
	var direction = Input.get_axis("move_left", "move_right")
	
	velocity.x = move_toward(velocity.x, direction * SPEED, delta * ACCELERATION)
	
	if !is_on_floor():
		velocity += get_gravity()
	elif Input.is_action_just_pressed("move_up"):
		velocity.y -= JUMP_STRENGTH
	
	collision_mask = normal_mask if !Input.is_action_pressed("move_down") else fall_mask
	
	move_and_slide()


func damage(damage: float):
	damage_taken += damage
