@abstract class_name State
extends Node


## The main node
@onready var main: Main = self.get_tree().current_scene
## The behaviour manager this state is attached to
@onready var manager: BehaviourManager = self.get_parent()
## The enemy this state is attached to
@onready var enemy: Enemy = manager.get_parent()
## The player that this enemy is fighting
@onready var player: Player = main.get_node("Player")


## Called when this state becomes the current state
@abstract func _enter()
## Called while this state is the current state
@abstract func _loop(delta: float)
## Called when switching the current state from this state to another state
@abstract func _exit()


## Used to execute a function after a specified amount of time.[br]
## Waits [code]time_sec[/code] seconds before calling [code]action[/code]
func wait_and_do(time_sec: float, action: Callable):
	await get_tree().create_timer(time_sec).timeout
	action.call()

## Used to execute a function if a condition is maintained for a specified amount of time.[br]
## Calls [code]cond[/code] until [code]time_sec[/code] seconds have passed. If the condition returns [code]false[/code], returns without calling [code]action[/code]. If the condition only returns [code]true[/code], call [code]action[/code] when the specified time has passed.
func wait_and_check(time_sec: float, action: Callable, cond: Callable):
	var count = 0
	while count < time_sec:
		count += .1
		await get_tree().create_timer(0.1).timeout
		if !cond.call():
			return
	action.call()
