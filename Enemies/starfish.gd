
extends Area2D

@export var speed: float = 180.0

func _ready() -> void:
	body_entered.connect(_on_body_entered)

func _physics_process(delta: float) -> void:
	global_position.x -= speed * delta

	if global_position.x < -200:
		queue_free()

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		get_tree().current_scene.game_over()
