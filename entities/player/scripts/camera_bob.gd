extends Camera3D

@onready var body : CharacterBody3D = get_parent().get_parent()

@export var player_stats : PlayerStats

var sway := 0.0

var speed := 1.0

func _process(delta):
	var vel := body.velocity.length()
	
	if Input.is_action_pressed("pl_sprint"):
		speed = move_toward(speed, player_stats.sprint_multiplier, delta)
	else:
		speed = move_toward(speed, 1.0, delta * 10.0)
	
	if vel > 0.0:
		sway += vel * delta * speed
		
		position = position.move_toward(
			Vector3(
				cos(sway * 1.0) * 0.05,
				sin(sway * 2.0) * 0.08,
				0.0
			),
			delta * 10
		)
	else:
		position = position.move_toward(Vector3.ZERO, delta)

