extends Area2D


@export var marker: Marker2D


func _on_body_entered(body: Node2D) -> void:
	body.reset()
	body.position = marker.position
