extends CharacterBody3D

@onready var states := $States

@onready var move_state := $States/DefaultState

func _ready():
	states.transition(move_state)
