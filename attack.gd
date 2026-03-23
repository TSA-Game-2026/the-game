@abstract class_name Attack
extends Node2D


@onready var player_class: Class = get_parent()
@onready var player: Player = player_class.get_parent()

@export var damage: float = 5
@export var knockback: Vector2 = Vector2.ZERO
@export var cooldown: float = 1
@export var stun_time: float = .5
@export var animation_time: float = 0.5 


@abstract func attack()
