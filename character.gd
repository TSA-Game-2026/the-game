class_name Character
extends CharacterBody2D


@export var speed := 350.0
@export var ground_acceleration := 2800.0
@export var air_acceleration := 1800.0
@export var jump_strength := 1200.0
@export var damage_knockback_mult := 0.005

var normal_mask = 0b00000011 # dont fall through platforms
var fall_mask   = 0b00000001 # do fall through platforms

## The direction that this character is trying to move
var move_direction: float = 0
## The last direction that the character moved in
var facing_direction = -1
## How much damage this character has takn
var damage_taken = 0
## Whether or not this character will fall through platforms
var falling = false

var stun_timer: float = 0



func _physics_process(delta: float) -> void:
	velocity.x = move_toward(velocity.x, (move_direction * speed) if (stun_timer <= 0) else 0.0, delta * (ground_acceleration if is_on_floor() else air_acceleration))
	
	if !is_on_floor():
		velocity += get_gravity()
	
	if velocity.x != 0:
		facing_direction = sign(velocity.x)
	
	collision_mask = normal_mask if !falling else fall_mask
	
	if stun_timer > 0:
		stun_timer = maxf(0, stun_timer - delta)
	
	move_and_slide()


func damage(damage_amt: float, knockback: Vector2):
	damage_taken += damage_amt
	velocity = knockback * (1 + damage_taken * damage_knockback_mult)
	stun(0.25)


func stun(stun_time: float):
	stun_timer = stun_time


func reset():
	velocity = Vector2.ZERO
	damage_taken = 0


func jump_if_grounded() -> bool:
	if !is_on_floor():
		return false
	velocity.y -= jump_strength
	return true


func set_falling(val: bool) -> void:
	falling = val
