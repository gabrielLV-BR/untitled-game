extends Node

var states : Array[Node]
var current_state : Node

func _ready():
	states = get_children()
	
	for state in states:
		state.set_process(false)

	current_state = states[0]

func transition(state: Node):
	if current_state.has_method("transition_out"):
		current_state.transition_out()
		
	current_state.set_process(false)
	current_state.set_physics_process(false)
	
	current_state = state
	
	if current_state.has_method("transition_in"):
		current_state.transition_in()
	
	current_state.set_process(true)
	current_state.set_physics_process(true)	
