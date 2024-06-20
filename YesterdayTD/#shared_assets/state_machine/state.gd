class_name State
extends Node


## emitting the signal will require self, as well as the new state
## i.e. transitioned.emit(self, new_state)
signal transitioned

var parent: Node2D
var initialized: bool = false

## only for attacks
var attack_number: int


## called when the state is created
func init() -> void:
	pass


## call if using init, this code is called every time state is entered
## if not used, the code in enter() will always call before init
func loop() -> void:
	pass


## called when state is entered
func enter() -> void:
	if not initialized:
		init()
		initialized = true
	
	loop()


## called when state transitions and exits
func exit() -> void:
	pass


## called every frame
func process(_delta: float) -> void:
	pass


## called every physics frame
func physics_process(_delta: float) -> void:
	pass


## simple function to check if the state is the state machine's current state
## may be bad practice to use get_parent but states should only be children to state machines anyway
func current_state() -> bool:
	if self.get_parent().current_state == self:
		return true
	return false
