extends Panel


@onready var main: Main = self.get_tree().current_scene


func _ready() -> void:
	$Control/CenterContainer/Control/AnimatedSprite2D.play()


func _process(delta: float) -> void:
	$Control/CenterContainer/Control/AnimatedSprite2D.speed_scale = 5 if main.swap_timer <= 5 else 1


func flip():
	var sprite = $Control/CenterContainer/Control/AnimatedSprite2D
	sprite.play()
	
	await sprite.animation_finished
	
	var flip_tween = create_tween().set_ignore_time_scale()
	flip_tween.tween_property($Control, "rotation_degrees", 180, 1)
	
	await flip_tween.finished
	
	sprite.play_backwards()
	
	await sprite.animation_finished
	
	var flip_tween_2 = create_tween().set_ignore_time_scale()
	flip_tween.tween_property($Control, "rotation_degrees", 0, 1)
	
	await flip_tween_2.finished

	flip()
