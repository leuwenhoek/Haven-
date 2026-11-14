
extends Node2D

@export var starfish_scene: PackedScene

@onready var game_over_ui = $GameOverUI
@onready var spawn_timer = $StarfishSpawnTimer
@onready var player = $Player

var is_game_over = false

func _ready() -> void:
	spawn_timer.timeout.connect(_on_spawn_timer_timeout)
	$GameOverUI/RestartButton.pressed.connect(restart_game)

func _on_spawn_timer_timeout() -> void:
	if is_game_over:
		return

	var starfish = starfish_scene.instantiate()
	starfish.scale = Vector2(0.5, 0.5)

	add_child(starfish)

	starfish.global_position = Vector2(
		player.global_position.x + 1000,
		425
	)

	starfish = starfish_scene.instantiate()
	add_child(starfish)

	starfish.global_position = Vector2(
		player.global_position.x + 1000,
		430
	)

func game_over():
	if is_game_over:
		return

	is_game_over = true
	game_over_ui.visible = true
	get_tree().paused = true


func restart_game() -> void:
	get_tree().paused = false
	get_tree().reload_current_scene()
