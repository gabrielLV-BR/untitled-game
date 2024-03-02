extends CharacterBody3D

const SPEED = 5.0
const JUMP_VELOCITY = 4.5

var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

@onready var arm_animator : AnimationPlayer = $Head/Arm/AnimationPlayer
@onready var animator : AnimationPlayer = $AnimationPlayer

var is_lighter_on := false

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("pl_left", "pl_right", "pl_forward", "pl_backward")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
	
# todo make this use actions
func _unhandled_input(_event):
	if Input.is_action_just_pressed("pl_use"):
		is_lighter_on = !is_lighter_on
		if is_lighter_on:
			# open
			arm_animator.play("LighterOn")
			animator.play("LightOn")
		else:
			arm_animator.play("LighterOn", -1, -1)
			animator.play("RESET")			
