extends Node

@export var initial_state : State

var current_state : State
var states : Dictionary = {}

func _ready():
	for child in get_children():
		if child is State:
			states[child.name.to_lower()] = child
			child.transitioned.connect(on_child_transition)
			
	if initial_state:
		initial_state.enter()
		current_state = initial_state

func _process(delta):
	if current_state:
		current_state.update(delta)
	
func _physics_process(delta):
	if current_state:
		current_state.physics_update(delta)

func on_child_transition(state, new_state_name): #Take the state that called for a new one and the new state
	if state != current_state:
		return
		
	var new_state = states.get(new_state_name.to_lower()) # Grab the new state from the states dictionary
	if !new_state: # Make sure the state exists
		return
		
	if current_state: # If we currently have a state, call the exit function
		current_state.exit()
	
	new_state.enter() # Enter the new state after exit
	
	current_state = new_state
