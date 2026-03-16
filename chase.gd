extends State


const TRACKING_MARGIN = 10


func _enter():
	pass


func _loop(_delta: float):
	enemy.direction = sign(player.position.x - enemy.position.x)
	
	enemy.falling = player.position.y - TRACKING_MARGIN > enemy.position.y
	
	jump_if_below()


func _exit():
	pass


func jump_if_below():
	var jump_cond = func(): return player.position.y + TRACKING_MARGIN < enemy.position.y
	if jump_cond.call():
		wait_and_check(.5, enemy.jump_if_grounded, jump_cond)
