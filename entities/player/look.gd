extends Node3D

const MOUSE_ACCELERATION : float = 2e-1
const MAX_CAMERA_PITCH : float = 80
const MIN_CAMERA_PITCH : float = -80

@onready var body : CharacterBody3D = get_parent()

var mouse_movement := Vector2.ZERO

var pitch := 0.0
var yaw := 0.0

func _process(delta):
	yaw += mouse_movement.x * delta
	pitch += mouse_movement.y * delta
	
	body.global_rotation = Vector3(0, yaw, 0)
	rotation = Vector3(
		clamp(pitch, MIN_CAMERA_PITCH, MAX_CAMERA_PITCH), 
		0, 
		0
	)
	
	mouse_movement = Vector2.ZERO
	
func _unhandled_input(event):
	if event is InputEventMouseMotion:
		event = event as InputEventMouseMotion
		
		mouse_movement.x = -event.relative.x * MOUSE_ACCELERATION
		mouse_movement.y = -event.relative.y * MOUSE_ACCELERATION
	elif event is InputEventMouseButton:
		event = event as InputEventMouseButton
		
		if event.button_index == MOUSE_BUTTON_LEFT:
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	elif event is InputEventKey:
		event = event as InputEventKey
		
		if event.keycode == KEY_ESCAPE:
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
