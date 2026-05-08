extends PanelContainer


@onready var main: Main = self.get_tree().current_scene


func _ready() -> void:
	$Control/CenterContainer/AnimatedSprite2D.play()


func _process(delta: float) -> void:
	$CenterContainer/AnimatedSprite2D.speed_scale = 5 if main.swap_timer <= 5 else 1


func flip():
	var flip_tween = create_tween().set_ignore_time_scale()
	flip_tween.tween_property($Control, "rotation", 180, 1)
	
	await flip_tween.finished
	
	$Control/CenterContainer/AnimatedSprite2D.play()
	$Control.rotation = 0


func _on_animated_sprite_2d_animation_finished() -> void:
	flip()
