class_name StateMachine
extends Node

@export var initial_state: State

var states := []
var current_state: State


## creation/initialization of state machine
func init(parent: Node2D) -> void:
	GlobalScripts.verify(self, parent, "parent")
	for child in get_children():
		if child is State:
			states.append(child)
			child.parent = parent
			child.transitioned.connect(on_state_transition)

	if is_instance_valid(initial_state):
		change_state(initial_state)
	else:
		printerr("No initial state has been set!")
		return


## handle state transitions
func on_state_transition(state: State, new_state: State):
	# if the transitioning state isn't the current state then stop caring
	if state != current_state:
		return

	if new_state in states:
		change_state(new_state)
	else:
		printerr("The state you are trying to transition to is not in the list of states!")
		return


## change states to the provided new_state
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
