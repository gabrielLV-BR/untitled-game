extends Node

@export_category("References")

@export var body : CharacterBody3D
@export var arm_animator : AnimationPlayer
@export var animator : AnimationPlayer

@export_category("Parameters")

@export var player_stats : PlayerStats

var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

var speed := 0.0

var is_lighter_on := false

func _process(delta):
	var input_dir = Input.get_vector(
		"pl_left", "pl_right", 
		"pl_forward", "pl_backward"
	)

	var direction = body.transform.basis * Vector3(input_dir.x, 0, input_dir.y)
	direction = direction.normalized()
	
	if Input.is_action_pressed("pl_sprint"):
		speed = move_toward(
			speed, 
			player_stats.speed * player_stats.sprint_multiplier, 
			delta * 5.0
		)
	else:
		speed = move_toward(speed, player_stats.speed, delta * 10.0)
	
	if direction != Vector3.ZERO:
		body.velocity.x = direction.x * speed
		body.velocity.z = direction.z * speed
	else:
		body.velocity.x = move_toward(body.velocity.x, 0, speed)
		body.velocity.z = move_toward(body.velocity.z, 0, speed)

func _physics_process(delta):
	if not body.is_on_floor():
		body.velocity.y -= gravity * delta
	
	body.move_and_slide()
	
func _unhandled_input(_event):
	if Input.is_action_just_pressed("pl_lighter"):
		if is_lighter_on:
			turn_lighter_off()
		else:
			turn_lighter_on()

func turn_lighter_on():
	arm_animator.play("LighterOn")
	animator.play("LightOn")
	
	is_lighter_on = true
	
func turn_lighter_off():
	arm_animator.play("LighterOn", -1, -1)
	animator.play("LightOn", -1, -1)
	
	is_lighter_on = false
