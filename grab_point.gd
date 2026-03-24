extends Node2D


var held_character: Character = null


func _process(_delta: float) -> void:
	if not held_character:
		return
	
	held_character.set_invulnerable(1)
	
	held_character.position = $HoldPoint.global_position
	held_character.velocity.x = 0
	held_character.velocity.y = min(0, held_character.velocity.y)


func _on_area_2d_body_entered(body: Character) -> void:
	if held_character:
		drop()
	held_character = body
	held_character.jumps = 1
	held_character.jump.connect(drop)
	held_character.attack.connect(drop)


func drop():
	held_character.jump.disconnect(drop)
	held_character.attack.disconnect(drop)
	held_character = null
