extends EnemyState

@export var attack_box: Area2D
@export var next_state: EnemyState

@export var stun_time: float = 0.5
@export var knockback_strength: Vector2 = Vector2.ZERO
@export var damage: float = 5


func _enter():
	enemy.move_direction = 0
	await attack()
	# switch back to chase
	manager.change_state(next_state)


func _loop(_delta: float):
	pass


func _exit():
	pass


func attack():
	# check if player in range
	# if player still in range:
	if player in attack_box.get_overlapping_bodies():
		player.damage(damage, knockback_strength * Vector2(enemy.facing_direction, 1))
	# wait stun_time seconds
	await get_tree().create_timer(stun_time).timeout
