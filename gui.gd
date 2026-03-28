extends Control


const lives_text = "     x%d"

@export var player: Player
@export var enemy: Enemy


func _process(_delta: float) -> void:
	$CanvasLayer/Panel/PlayerDisplay/VBoxContainer/HBoxContainer/VBoxContainer/PlayerDamage.text = str(player.damage_taken) + "%"
	$CanvasLayer/Panel/EnemyDisplay/VBoxContainer/HBoxContainer/VBoxContainer/EnemyDamage.text = str(enemy.damage_taken) + "%"
	$CanvasLayer/Panel/PlayerDisplay/VBoxContainer/HBoxContainer/VBoxContainer/PlayerLives.text = lives_text % player.lives
	$CanvasLayer/Panel/EnemyDisplay/VBoxContainer/HBoxContainer/VBoxContainer/EnemyLives.text = lives_text % enemy.lives


func _on_button_pressed() -> void:
	$CanvasLayer/Panel2.hide()
