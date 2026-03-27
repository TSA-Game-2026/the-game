class_name Main
extends Node2D


enum Arenas {
	PREHISTORIC,
	SPACE,
}
 
## The player character
@export var player: Player
## The current enemy character
@export var enemy: Enemy

## The arena that is currently in play
@export var current_arena: Arena

@export var prehistoric_arena: PackedScene = preload("res://prehistoric_arena.tscn")
@export var space_arena: PackedScene = preload("res://space_arena.tscn")


func _ready() -> void:
	$AudioStreamPlayer.stream = current_arena.music
	$AudioStreamPlayer.play()


func change_arena(new_arena: Arenas) -> void:
	current_arena.queue_free()
	var arena_inst
	
	match new_arena:
		Arenas.PREHISTORIC:
			arena_inst = prehistoric_arena.instantiate()
		Arenas.SPACE:
			arena_inst = space_arena.instantiate()
	
	add_child(arena_inst)
	current_arena = arena_inst
	
	player.position.y = -350
	enemy.position.y = -350
