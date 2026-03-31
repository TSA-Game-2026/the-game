class_name GUI
extends Control


const lives_text = "     x%d"


@onready var level_1_button: Button = $CanvasLayer/Panel2/Level1Button
@onready var level_2_button: Button = $CanvasLayer/Panel2/Level2Button
@onready var level_3_button: Button = $CanvasLayer/Panel2/Level3Button
@onready var main_menu: Panel = $CanvasLayer/Panel2


func update(player: Player, enemy: Enemy) -> void:
	$CanvasLayer/Panel/PlayerDisplay/VBoxContainer/HBoxContainer/VBoxContainer/PlayerDamage.text = str(player.damage_taken) + "%"
	$CanvasLayer/Panel/EnemyDisplay/VBoxContainer/HBoxContainer/VBoxContainer/EnemyDamage.text = str(enemy.damage_taken) + "%"
	$CanvasLayer/Panel/PlayerDisplay/VBoxContainer/HBoxContainer/VBoxContainer/PlayerLives.text = lives_text % player.lives
	$CanvasLayer/Panel/EnemyDisplay/VBoxContainer/HBoxContainer/VBoxContainer/EnemyLives.text = lives_text % enemy.lives


func _on_button_pressed() -> void:
	$CanvasLayer/Panel2.hide()
