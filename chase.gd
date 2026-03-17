extends State


const TRACKING_MARGIN = 10


func _enter():
	pass


func _loop(_delta: float):
	enemy.direction = sign(player.position.x - enemy.position.x)
	
	var fall_cond = func(): return player.position.y - TRACKING_MARGIN > enemy.position.y
	if fall_cond.call():
		wait_and_check(.5, func(): enemy.set_falling(true); wait_and_do(.1, enemy.set_falling.bind(false)), fall_cond)

	
	jump_if_below()


func _exit():
	pass


func jump_if_below():
	var jump_cond = func(): return player.position.y + TRACKING_MARGIN < enemy.position.y
	if jump_cond.call():
		wait_and_check(.5, enemy.jump_if_grounded, jump_cond)
