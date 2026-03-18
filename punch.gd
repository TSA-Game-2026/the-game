extends State

@export var attack_box: Area2D
@export var next_state: State

@export var hit_delay = .3
@export var stun_time = .5
@export var knockback_strength: Vector2 = Vector2.ZERO
@export var damage: float = 5


func _enter():
	pass
	attack()
	# switch back to chase
	manager.change_state(next_state)


func _loop(delta: float):
	pass


func _exit():
	pass	


func attack():
	# wait hit_delay seconds
	await get_tree().create_timer(hit_delay).timeout
	# check if player in range
	# if player still in range:
	if player in attack_box.get_overlapping_bodies():
		player.velocity += knockback_strength
		player.damage(damage)
	# wait stun_time seconds
	await get_tree().create_timer(stun_time).timeout
