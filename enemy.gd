class_name Enemy
extends Character


func _process(_delta: float) -> void:
	$AnimatedSprite2D.flip_h = sign(facing_direction) == -1
