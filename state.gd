@abstract class_name State
extends Node

@onready var manager: BehaviourManager = self.get_parent()
@onready var enemy: Enemy = manager.get_parent()
@onready var player: Player = self.get_tree().current_scene.get_node("Player")


@abstract func _enter()
@abstract func _loop(delta: float)
@abstract func _exit()
