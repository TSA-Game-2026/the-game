class_name Main
extends Node2D


enum Arenas {
	PREHISTORIC,
	SPACE,
}

## The arena that is currently in play
@export var current_arena: Arena
@export var current_player: Player
@export var current_enemies: Array[Enemy]

@export var prehistoric_arena: PackedScene = preload("res://prehistoric_arena.tscn")
@export var space_arena: PackedScene = preload("res://space_arena.tscn")

@export var prehistoric_class: PackedScene = preload("res://caveman.tscn")
@export var space_class: PackedScene = preload("res://astronaut.tscn")

@export var min_swap_time: float = 20
@export var max_swap_time: float = 40

@onready var player: PackedScene = preload("res://player.tscn")
@onready var enemy1: PackedScene = preload("res://paytenemy.tscn")
@onready var enemy2: PackedScene = preload("res://alenemy.tscn")

@onready var gui: GUI = $GUI
@onready var audio: AudioStreamPlayer = $AudioStreamPlayer

var playing: bool = false
var swap_timer: float = 1#randf_range(min_swap_time, max_swap_time)
var next_arena: Arenas = Arenas.SPACE


func _ready() -> void:
	gui.level_1_button.pressed.connect(start_level.bind(1))
	gui.level_2_button.pressed.connect(start_level.bind(2))
	gui.level_3_button.pressed.connect(start_level.bind(3))


func _process(delta: float) -> void:
	if not playing:
		return
	$GUI.update(current_player, current_enemies)
	
	if current_player.lives <= 0:
		level_over(false)
	for enemy: Enemy in current_enemies:
		if enemy.lives <= 0:
			current_enemies.erase(enemy)
			if len(current_enemies) <= 0:
				level_over(true)
			else:
				enemy.queue_free()
	
	swap_timer -= delta
	if swap_timer <= 0:
		set_arena(next_arena)
		next_arena = Arenas.PREHISTORIC if next_arena == Arenas.SPACE else Arenas.SPACE
		swap_timer = randf_range(min_swap_time, max_swap_time)


func set_arena(new_arena: Arenas, swirl: bool=true) -> void:
	if swirl:
		await gui.swirl()
	
	if current_arena:
		current_arena.queue_free()
	var arena_inst
	
	match new_arena:
		Arenas.PREHISTORIC:
			arena_inst = prehistoric_arena.instantiate()
			current_player.set_class(prehistoric_class)
		Arenas.SPACE:
			arena_inst = space_arena.instantiate()
			current_player.set_class(space_class)
	
	add_child(arena_inst)
	current_arena = arena_inst
	
	$AudioStreamPlayer.stream = current_arena.music
	$AudioStreamPlayer.play()
	
	#for character: Character in [current_player] + current_enemies:
		#character.position.y = -350
		#character.velocity = Vector2.ZERO
	
	if swirl:
		current_player.jumps = max(1, current_player.jumps)
		await gui.unswirl()


func start_level(level_num: int):
	playing = true
	gui.main_menu.hide()
	
	current_player = player.instantiate()
	add_child(current_player)
	current_player.position = $PlayerSpawn.position
	
	match level_num:
		1:
			current_enemies = [enemy1.instantiate()]
		2:
			current_enemies = [enemy2.instantiate()]
		3:
			current_enemies = [enemy1.instantiate(), enemy2.instantiate()]
	
	for current_enemy in current_enemies:
		add_child(current_enemy)
		current_enemy.position = $EnemySpawn.position
	
	set_arena(Arenas.PREHISTORIC, false)
	next_arena = Arenas.SPACE


func level_over(win: bool) -> void:
	gui.update(current_player, current_enemies)

	playing = false
	gui.end_menu.show()
	if win:
		gui.win_menu.show()
		gui.lose_menu.hide()
	else:
		gui.win_menu.hide()
		gui.lose_menu.show()


func reset():
	for character: Character in [current_player] + current_enemies:
		character.queue_free()
