extends Area3D

@onready var parent : CSGBox3D = get_parent()

func interaction_lookat():
	print("Looking at me")
	parent.scale = Vector3(1.5, 1.5, 1.5)

func interaction_lookaway():
	parent.scale = Vector3(1, 1, 1)

func interaction_do(_interactor):
	parent.queue_free()	
