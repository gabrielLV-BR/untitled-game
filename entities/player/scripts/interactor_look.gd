extends Area3D

@export var cursor_sprite : Sprite2D

# really cringe but godot offers no better way to do this
@export_group("Cursor textures")

# make sure the order is the same, makes the code simples
@export var cursor_textures : Array[Texture2D]

func set_cursor_type(type: int):
	if type < 0 || type > 3:
		type = 0

	cursor_sprite.texture = cursor_textures[type]		

func _on_area_look_at(area):
	if area.has_method("interaction_lookat"):
		var type = area.interaction_lookat()

		if type != null:
			set_cursor_type(type)

func _on_area_look_away(area):
	if area.has_method("interaction_lookaway"):
		area.interaction_lookaway()
	
	set_cursor_type(InteractionType.NONE)
