class_name Main
extends Node2D


enum Arenas {
	PREHISTORIC,
	SPACE,
}

## The arena that is currently in play
@export var current_arena: Arena

@export var prehistoric_arena: PackedScene = preload("res://prehistoric_arena.tscn")
@export var space_arena: PackedScene = preload("res://space_arena.tscn")


func change_arena(new_arena: Arenas):
	current_arena.queue_free()
	var arena_inst
	
	match new_arena:
		Arenas.PREHISTORIC:
			arena_inst = prehistoric_arena.instantiate()
		Arenas.SPACE:
			arena_inst = space_arena.instantiate()
	
	add_child(arena_inst)
	current_arena = arena_inst
