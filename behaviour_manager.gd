class_name BehaviourManager
extends Node


@export var current_state: State


func _ready() -> void:
	current_state._enter()


func _physics_process(delta: float) -> void:
	var enemy: Enemy = get_parent()
	if enemy.stun_timer == 0:
		current_state._loop(delta)


## Exits the current state and switches to the given state.
func change_state(state: State) -> void:
	current_state._exit()
	current_state = state
	state._enter()
