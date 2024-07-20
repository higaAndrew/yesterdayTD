class_name AttackStateMachine
extends StateMachine


@export var attack_number: int


## creation/initialization of state machine
func init(parent: Node) -> void:
	for child in get_children():
		if child is State:
			states[child.name.to_lower()] = child
			child.parent = parent
			child.attack_number = attack_number
			child.transitioned.connect(on_state_transition)

	if is_instance_valid(initial_state):
		change_state(initial_state)
	else:
		printerr("No initial state has been set for %s's attack state machine!" % parent.name)
		return
