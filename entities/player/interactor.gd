extends RayCast3D

func _process(_delta):
	if is_colliding():
		var object = get_collider()
		
		if object.has_method("interaction_do"):
			object.interaction_do(null)

func _unhandled_input(_event):
	enabled = Input.is_action_just_pressed("pl_interact")
