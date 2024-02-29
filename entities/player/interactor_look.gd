extends Area3D

func _on_area_look_at(area):
	if area.has_method("interaction_lookat"):
		area.interaction_lookat()

func _on_area_look_away(area):
	if area.has_method("interaction_lookaway"):
		area.interaction_lookaway()
