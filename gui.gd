class_name GUI
extends Control


const lives_text = "     x%d"

@onready var level_1_button: Button = $CanvasLayer/MainMenu/Level1Button
@onready var level_2_button: Button = $CanvasLayer/MainMenu/Level2Button
@onready var level_3_button: Button = $CanvasLayer/MainMenu/Level3Button
@onready var main_menu: Panel = $CanvasLayer/MainMenu
@onready var end_menu = $CanvasLayer/EndMenu
@onready var win_menu = $CanvasLayer/EndMenu/YouWin
@onready var lose_menu = $CanvasLayer/EndMenu/YouLose


func _ready() -> void:
	$CanvasLayer.show()


func update(player: Player, enemies: Array[Enemy]) -> void:
	$CanvasLayer/Overlay/PlayerDisplay/VBoxContainer/HBoxContainer/VBoxContainer/PlayerDamage.text = str(player.damage_taken) + "%"
	$CanvasLayer/Overlay/PlayerDisplay/VBoxContainer/HBoxContainer/VBoxContainer/PlayerLives.text = lives_text % player.lives
	
	$CanvasLayer/Overlay/HBoxContainer/EnemyDisplay/VBoxContainer/HBoxContainer/VBoxContainer/EnemyDamage.text = str(enemies[0].damage_taken) + "%"
	$CanvasLayer/Overlay/HBoxContainer/EnemyDisplay/VBoxContainer/HBoxContainer/VBoxContainer/EnemyLives.text = lives_text % enemies[0].lives
	
	if len(enemies) == 2:
		$CanvasLayer/Overlay/HBoxContainer/EnemyDisplay2.show()
		$CanvasLayer/Overlay/HBoxContainer/EnemyDisplay2/VBoxContainer/HBoxContainer/VBoxContainer/EnemyDamage.text = str(enemies[1].damage_taken) + "%"
		$CanvasLayer/Overlay/HBoxContainer/EnemyDisplay2/VBoxContainer/HBoxContainer/VBoxContainer/EnemyLives.text = lives_text % enemies[1].lives
	else:
		$CanvasLayer/Overlay/HBoxContainer/EnemyDisplay2.hide()


func _on_button_pressed() -> void:
	$CanvasLayer/MainMenu.hide()


func _on_end_button_pressed():
	main_menu.show()
	end_menu.hide()
	get_parent().reset()


func swirl():
	var time_tween: Tween = create_tween().set_ignore_time_scale().set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_QUAD)
	time_tween.tween_property(Engine, "time_scale", 0, 1.5)
	
	var swirl_tween = create_tween().set_parallel().set_trans(Tween.TRANS_QUINT).set_ignore_time_scale()
	
	swirl_tween.tween_method(func(x): $CanvasLayer/ColorRect.material.set_shader_parameter("swirl_strength", x), 0.0, 20.0, 3)
	swirl_tween.tween_property($CanvasLayer/ColorRect2, "color:a", 1, 3)
	swirl_tween.tween_property(get_parent().audio, "volume_db", -80, 3)
	
	swirl_tween.chain().tween_interval(1) # time between swirls
	
	await swirl_tween.finished


func unswirl():
	var swirl_tween = create_tween().set_parallel().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_QUINT).set_ignore_time_scale()
	
	swirl_tween.tween_method(func(x): $CanvasLayer/ColorRect.material.set_shader_parameter("swirl_strength", x), -20.0, 0, 3)
	swirl_tween.tween_property($CanvasLayer/ColorRect2, "color:a", 0, 3)
	swirl_tween.tween_property(get_parent().audio, "volume_db", 0, 3)
	
	var time_tween: Tween = create_tween().set_ignore_time_scale().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_QUAD)
	time_tween.tween_interval(1.5)
	time_tween.tween_property(Engine, "time_scale", 1, 1.5)
	
	await swirl_tween.finished
