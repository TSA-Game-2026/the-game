extends Node2D


@export var top_left_marker: Marker2D
@export var bottom_right_marker: Marker2D
@export var rocks: Array[PackedScene] = [
	preload("res://rock.tscn"),
	preload("res://big_rock.tscn"),
]
@export var min_spawn_time: float = 7
@export var max_spawn_time: float = 10
@export var rock_velocity: Vector2 = Vector2(200, 0)
@export var initial_spawn_time: float = 15

var rock_mask = 0b00001111

var spawn_timer: float = 0


func _process(delta: float) -> void:
	spawn_timer -= delta
	
	if spawn_timer <= 0:
		spawn_rock()
		spawn_timer = randf_range(min_spawn_time, max_spawn_time)


func spawn_rock():
	var new_rock: RigidBody2D = rocks.pick_random().instantiate()
	new_rock.position = Vector2(randf_range(top_left_marker.position.x, bottom_right_marker.position.x), randf_range(top_left_marker.position.y, bottom_right_marker.position.y))
	new_rock.linear_velocity = rock_velocity
	new_rock.collision_mask = rock_mask
	get_tree().current_scene.add_child(new_rock)
