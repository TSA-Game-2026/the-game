extends RigidBody2D


@export var damage: float = 15
@export var knockback: Vector2 = Vector2(700, -600)
@export var spin: bool = true


func _process(_delta: float) -> void:
	if !spin:
		angular_velocity = 0


func _on_body_entered(body: Node) -> void:
	if body is Character:
		body.damage(damage, knockback * Vector2(sign((body.position - position).x), 1))
	queue_free()
