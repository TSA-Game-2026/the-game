extends RigidBody2D


@export var damage: float = 15
@export var knockback: Vector2 = Vector2(700, -600)


func _on_body_entered(body: Node) -> void:
	if body is Character:
		body.damage(damage, knockback * Vector2(sign((body.position - position).x), 1))
	queue_free()
