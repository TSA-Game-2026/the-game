extends Attack


func attack():
	for enemy: Enemy in $AttackBox.get_overlapping_bodies():
		enemy.damage(damage, knockback * Vector2(player.facing_direction, 1))
