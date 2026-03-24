class_name Player
extends Character


@export var current_class: Class


func _physics_process(delta: float) -> void:
	super(delta)
	
	move_direction = Input.get_axis("move_left", "move_right")
	falling = Input.is_action_pressed("move_down")
	
	if ( Input.is_action_just_pressed("move_up") or (Input.is_action_pressed("move_up") and is_on_floor()) ) and stun_timer <= 0:
		try_jump()
	
	current_class.attack_if_pressed()
