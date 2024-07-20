class_name StateMachine
extends Node


@export var initial_state: State

var states: Dictionary = {}
var current_state: State


## creation/initialization of state machine
func init(parent: Node) -> void:
	for child in get_children():
		if child is State:
			states[child.name.to_lower()] = child
			child.parent = parent
			child.transitioned.connect(on_state_transition)
	
	if is_instance_valid(initial_state):
		change_state(initial_state)
	else:
		printerr("No initial state has been set for %s's state machine!" % parent.name)
		return


## handle state transitions
func on_state_transition(state: State, new_state_name: String):
	# if the transitioning state isn't the current state then stop caring
	if state != current_state:
		printerr("An inactive state (%s) attempted to transition!" % state.name)
		return

	# if the new state's name is in the states dictionary, change the state to the new state
	if new_state_name.to_lower() in states:
		change_state(states[new_state_name.to_lower()])
	else:
		printerr("The state you are trying to transition to (%s) is not in the list of states!" % new_state_name)
		return


## change states to the provided new state
func change_state(new_state: State) -> void:
	if is_instance_valid(current_state):
		current_state.exit()

	current_state = new_state
	current_state.enter()


## every frame, update the current state
func _process(delta: float) -> void:
	if is_instance_valid(current_state):
		current_state.process(delta)


## every physics frame, update the current state
func _physics_process(delta: float) -> void:
	if is_instance_valid(current_state):
		current_state.physics_process(delta)
