class_name Enemy
extends CharacterBody2D


const SPEED = 300
const ACCELERATION = 2500
const JUMP_STRENGTH = 1200

var normal_mask = 0b00000011 # dont fall through platforms
var fall_mask   = 0b00000001 # do fall through platforms

## When [code]true[/code] the enemy will fall through platforms
var falling := false
## The direction in which the enemy is moving on the horizontal plane
var direction = 0


func _ready() -> void:
	pass


func _physics_process(delta: float) -> void:
	velocity.x = move_toward(velocity.x, direction * SPEED, delta * ACCELERATION)
	
	if !is_on_floor():
		velocity += get_gravity()
	
	collision_mask = normal_mask if !falling else fall_mask
	
	move_and_slide()


func jump_if_grounded() -> bool:
	if !is_on_floor():
		return false
	velocity.y -= JUMP_STRENGTH
	return true
	
	
func set_falling(val: bool) -> void:
	falling = val
