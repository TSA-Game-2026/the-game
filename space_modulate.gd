extends Sprite2D


@export var max_value = 1-.38
@export var speed = .02

var dir: int = 1
var count: float = 0


func _process(delta: float) -> void:
	count = clampf(count + (speed * delta * dir), 0, max_value)
	
	if count == 0:
		dir = 1
	if count == max_value:
		dir = -1
	
	self_modulate = Color(count+0.38, 0.3, 1-count)
