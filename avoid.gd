extends EnemyState


const TRACKING_MARGIN = 10

@export var attack_state: EnemyState
@export var target_dist: float = 192
@export var jump_dist: float = 64

var target_offset = target_dist


func _enter():
	pass


func _loop(delta: float):
	if player.position.x + target_dist >= main.current_arena.right_marker.position.x:
		target_offset = -target_dist
	elif player.position.x - target_dist <= main.current_arena.left_marker.position.x:
		target_offset = target_dist
		
	if enemy.position.x < main.current_arena.left_marker.position.x:
		enemy.move_direction = 1
		enemy.try_jump()
	
	elif enemy.position.x > main.current_arena.right_marker.position.x:
		enemy.move_direction = -1
		enemy.try_jump()
	
	else:
		enemy.move_direction = sign((player.position.x + target_offset) - enemy.position.x)
	
	if abs(enemy.position.x - player.position.x) <= jump_dist and enemy.position.y - TRACKING_MARGIN <= player.position.y and enemy.is_on_floor():
		enemy.try_jump()
	
	fall_if_above()
	
	jump_if_below()
	
	if attack_state.can_attack():
		manager.change_state(attack_state)
	if attack_state.cooldown_timer > 0:
		attack_state.cooldown_timer = max(0, attack_state.cooldown_timer - delta)


func _exit():
	pass


func fall_if_above():
	var fall_cond = func(): return player.position.y - TRACKING_MARGIN > enemy.position.y
	if fall_cond.call():
		wait_and_check(.5, func(): enemy.set_falling(true); wait_and_do(.1, enemy.set_falling.bind(false)), fall_cond)


func jump_if_below():
	var jump_cond = func(): return player.position.y + TRACKING_MARGIN < enemy.position.y
	if jump_cond.call():
		wait_and_check(.5, enemy.try_jump, jump_cond)
