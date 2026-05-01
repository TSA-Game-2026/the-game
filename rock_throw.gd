extends EnemyState


@export var next_state: EnemyState
@export var left_raycast: RayCast2D
@export var right_raycast: RayCast2D

@export var rock: PackedScene = preload("res://rock.tscn")

@export var stun_time: float = 1
@export var min_cooldown: float = 4
@export var max_cooldown: float = 6

var cooldown_timer: float = max_cooldown


func _enter():
	enemy.move_direction = 0
	cooldown_timer = randf_range(min_cooldown, max_cooldown)
	
	var new_rock: RigidBody2D = rock.instantiate()
	new_rock.position = enemy.global_position
	main.add_child(new_rock)
	new_rock.linear_velocity = Vector2(300, 0) * sign((player.position - enemy.position).x)
	
	wait_and_do(stun_time, manager.change_state.bind(next_state))


func _loop(_delta):
	pass


func _exit():
	pass


func can_attack() -> bool:
	return (left_raycast.is_colliding() or right_raycast.is_colliding()) and cooldown_timer <= 0
