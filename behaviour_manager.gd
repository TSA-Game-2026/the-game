class_name BehaviourManager
extends Node


@export var current_state: State


func change_state(state: State) -> void:
	current_state._exit()
	current_state = state
	state._enter()


func _process(delta: float) -> void:
	current_state._loop(delta)
