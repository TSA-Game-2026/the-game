extends Area2D


@export var marker: Marker2D


func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		body.position = marker.position
		body.velocity = Vector2.ZERO
