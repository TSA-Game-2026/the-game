extends State


const TRACKING_MARGIN = 10

@export var attack_box: Area2D
@export var hit_state: State
@export var attack_in_range_min_time: float = 0.1
@export var attack_in_range_max_time: float = 0.4

var attack_timer = attack_in_range_max_time


func _enter():
	pass


func _loop(delta: float):
	if enemy.position.x < main.arena.left_marker.position.x:
		enemy.move_direction = 1
	
	elif enemy.position.x > main.arena.right_marker.position.x:
		enemy.move_direction = -1
	
	else:
		enemy.move_direction = sign(player.position.x - enemy.position.x)
	
	
	fall_if_above()
	
	jump_if_below()
	
	if player in attack_box.get_overlapping_bodies():
		attack_timer -= delta
		if attack_timer <= 0:
			manager.change_state(hit_state)
	else:
		attack_timer = randf_range(attack_in_range_min_time, attack_in_range_max_time)


func _exit():
	pass


func fall_if_above():
	var fall_cond = func(): return player.position.y - TRACKING_MARGIN > enemy.position.y
	if fall_cond.call():
		wait_and_check(.5, func(): enemy.set_falling(true); wait_and_do(.1, enemy.set_falling.bind(false)), fall_cond)


func jump_if_below():
	var jump_cond = func(): return player.position.y + TRACKING_MARGIN < enemy.position.y
	if jump_cond.call():
		wait_and_check(.5, enemy.jump_if_grounded, jump_cond)
