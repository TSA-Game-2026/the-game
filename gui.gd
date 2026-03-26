extends Control

@export var player: Player
@export var enemy: Enemy


func _process(_delta: float) -> void:
	$CanvasLayer/Panel/PlayerDisplay/VBoxContainer/HBoxContainer/PlayerDamage.text = str(player.damage_taken) + "%"
	$CanvasLayer/Panel/EnemyDisplay/VBoxContainer/HBoxContainer/EnemyDamage.text = str(enemy.damage_taken) + "%"
