extends Attack


@export var rock: PackedScene = preload("res://rock.tscn")

var rock_mask = 0b00001011


func attack():
	var new_rock: RigidBody2D = rock.instantiate()
	new_rock.position = player.global_position
	new_rock.collision_mask = rock_mask
	main.add_child(new_rock)
	new_rock.linear_velocity = Vector2(300, 0) * player.facing_direction
	
