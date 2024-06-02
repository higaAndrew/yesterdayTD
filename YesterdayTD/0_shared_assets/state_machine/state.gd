class_name State
extends Node

## emitting the signal will require self, as well as the new state
## i.e. emit_signal("transitioned", self, new_state)
signal transitioned

var parent: Node2D


## called when state is entered
func enter() -> void:
	pass


## called when state transitions and exits
func exit() -> void:
	pass


## called every frame
func process(_delta: float) -> void:
	pass


## called every physics frame
func physics_process(_delta: float) -> void:
	pass
