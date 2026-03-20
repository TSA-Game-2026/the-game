class_name Player
extends Character


func _physics_process(delta: float) -> void:
	super(delta)
	
	move_direction = Input.get_axis("move_left", "move_right")
	falling = Input.is_action_pressed("move_down")
	
	if Input.is_action_pressed("move_up"):
		jump_if_grounded()
