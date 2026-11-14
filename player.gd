
extends CharacterBody2D

const SPEED = 400.0
const ACCELERATION = 1200.0
const FRICTION = 1500.0
const GRAVITY = 1500.0
const JUMP_VELOCITY = -450.0
const JUMP_CUT = 0.5

const LEFT_BOUNDARY = 50.0
const RIGHT_BOUNDARY = 5950.0

func _physics_process(delta: float) -> void:
	var direction = Input.get_axis("ui_left", "ui_right")

	if direction != 0:
		velocity.x = move_toward(
			velocity.x,
			direction * SPEED,
			ACCELERATION * delta
		)
	else:
		velocity.x = move_toward(
			velocity.x,
			0,
			FRICTION * delta
		)

	if not is_on_floor():
		velocity.y += GRAVITY * delta

	var jump_pressed = (
		Input.is_action_just_pressed("ui_accept")
		or Input.is_action_just_pressed("ui_up")
	)

	var jump_released = (
		Input.is_action_just_released("ui_accept")
		or Input.is_action_just_released("ui_up")
	)

	if jump_pressed and is_on_floor():
		velocity.y = JUMP_VELOCITY

	if jump_released and velocity.y < 0:
		velocity.y *= JUMP_CUT

	move_and_slide()

	if global_position.x < LEFT_BOUNDARY:
		global_position.x = LEFT_BOUNDARY
		velocity.x = maxf(velocity.x, 0.0)

	if global_position.x > RIGHT_BOUNDARY:
		global_position.x = RIGHT_BOUNDARY
		velocity.x = minf(velocity.x, 0.0)
