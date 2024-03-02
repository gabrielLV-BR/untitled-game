extends Camera3D

@onready var body : CharacterBody3D = get_parent().get_parent()

var sway := 0.0

func _process(delta):
	var vel := body.velocity.length()
	
	if vel > 0.0:
		sway += vel * delta
		
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
	
