extends Area2D


@onready var marker: Marker2D = get_parent().spawn_marker


func _on_body_entered(body: Node2D) -> void:
	body.reset()
	body.position = marker.position
