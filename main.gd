class_name Main
extends Node2D


enum Arenas {
	PREHISTORIC,
	SPACE,
}

## The arena that is currently in play
@export var current_arena: Arena
@export var current_player: Player
@export var current_enemy: Enemy

@export var prehistoric_arena: PackedScene = preload("res://prehistoric_arena.tscn")
@export var space_arena: PackedScene = preload("res://space_arena.tscn")

@export var min_swap_time: float = 20
@export var max_swap_time: float = 40

@onready var player: PackedScene = preload("res://player.tscn")
@onready var enemy: PackedScene = preload("res://paytenemy.tscn")

@onready var gui: GUI = $GUI

var playing: bool = false
var swap_timer: float = randf_range(min_swap_time, max_swap_time)
var next_arena: Arenas = Arenas.SPACE


func _ready() -> void:
	gui.level_1_button.pressed.connect(start_level.bind(1))
	gui.level_2_button.pressed.connect(start_level.bind(2))
	gui.level_3_button.pressed.connect(start_level.bind(3))


func _process(delta: float) -> void:
	if not playing:
		return
	$GUI.update(player, enemy)
	swap_timer -= delta
	if swap_timer <= 0:
		set_arena(next_arena)
		next_arena = Arenas.PREHISTORIC if next_arena == Arenas.SPACE else Arenas.SPACE


func set_arena(new_arena: Arenas) -> void:
	if current_arena:
		current_arena.queue_free()
	var arena_inst
	
	match new_arena:
		Arenas.PREHISTORIC:
			arena_inst = prehistoric_arena.instantiate()
		Arenas.SPACE:
			arena_inst = space_arena.instantiate()
	
	add_child(arena_inst)
	current_arena = arena_inst
	
	$AudioStreamPlayer.stream = current_arena.music
	$AudioStreamPlayer.play()
	
	current_player.position.y = -350
	current_enemy.position.y = -350


func start_level(level_num: int):
	gui.main_menu.hide()
	
	current_player = player.instantiate()
	add_child(current_player)
	current_player.position = $PlayerSpawn.position
	
	current_enemy = enemy.instantiate()
	add_child(current_enemy)
	current_enemy.position = $EnemySpawn.position
	
	set_arena(Arenas.PREHISTORIC)
	next_arena = Arenas.SPACE


func level_over() -> void:
	current_player.process_mode = Node.PROCESS_MODE_DISABLED
	current_enemy.process_mode = Node.PROCESS_MODE_DISABLED
