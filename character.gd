class_name Character
extends CharacterBody2D


signal jump
signal attack

const jump_delay = .5
const terminal_velocity = 800

@export var speed := 350.0
@export var ground_acceleration := 2800.0
@export var air_acceleration := 1800.0
@export var jump_strength := -850.0
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
## How many lives this character has left
var lives: int = 2

var jumps: int = 0
var jump_timer: float = 0
var stun_timer: float = 0
var i_timer: float = 0

var prev_on_floor = false



func _physics_process(delta: float) -> void:
	velocity.x = move_toward(velocity.x, (move_direction * speed) if (stun_timer <= 0) else 0.0, delta * (ground_acceleration if is_on_floor() else air_acceleration))
	
	if !is_on_floor():
		velocity.y = min(terminal_velocity, velocity.y + get_gravity().y)
	else:
		jumps = 1
	if is_on_floor() and not prev_on_floor:
		print("NO JUMP")
		jump_timer = jump_delay
	
	if velocity.x != 0:
		facing_direction = sign(velocity.x)
	
	collision_mask = normal_mask if !falling else fall_mask
	
	if jump_timer > 0:
		jump_timer = maxf(0, jump_timer - delta)
	if stun_timer > 0:
		stun_timer = maxf(0, stun_timer - delta)
	if i_timer > 0:
		i_timer = maxf(0, i_timer - delta)
	
	move_and_slide()
	
	prev_on_floor = is_on_floor()


func damage(damage_amt: float, knockback: Vector2):
	if i_timer > 0:
		return
	damage_taken += damage_amt
	velocity = knockback * (1 + damage_taken * damage_knockback_mult)
	stun(0.25)


func stun(stun_time: float):
	stun_timer = stun_time


func set_invulnerable(time: float):
	i_timer = time


func reset():
	velocity = Vector2.ZERO
	damage_taken = 0
	lives -= 1
	if lives <= 0:
		get_parent().level_over()


func try_jump() -> bool:
	if jumps <= 0:
		return false
	if jump_timer > 0:
		return false
	velocity.y = jump_strength
	jumps -= 1
	jump.emit()
	return true


func set_falling(val: bool) -> void:
	falling = val
