class_name Class
extends Node2D


@export var attack_mapping: Dictionary[String, Attack] = {
	"primary_attack": null,
	"secondary_attack": null,
	"tertiary_attack": null,
}

var cooldown_timer = 0


func _process(delta: float) -> void:
	if cooldown_timer > 0:
		cooldown_timer = maxf(0, cooldown_timer - delta)
		if cooldown_timer == 0:
			for child in get_children():
				child.hide()
			show()


func attack_if_pressed():
	for action in attack_mapping:
		var attack = attack_mapping[action]
		if Input.is_action_just_pressed(action) and cooldown_timer == 0:
			for child in get_children():
				child.hide()
			attack.show()
			attack.attack()
			
