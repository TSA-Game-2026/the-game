extends State


const TRACKING_MARGIN = 10


func _enter():
	pass


func _loop(delta: float):
	enemy.direction = sign(player.position.x - enemy.position.x)
	
	enemy.falling = player.position.y - TRACKING_MARGIN > enemy.position.y
	
	var jump_cond = func(): return player.position.y + TRACKING_MARGIN < enemy.position.y
	if jump_cond.call():
		wait_and_jump(jump_cond)


func wait_and_jump(cond: Callable):
	await get_tree().create_timer(.25).timeout
	if cond.call():
		enemy.jump_if_grounded()


func _exit():
	pass
