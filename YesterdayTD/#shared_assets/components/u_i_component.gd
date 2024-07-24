class_name UIComponent
extends Node


signal tower_placed

var parent: Area2D
var mouse_hovering: bool = false
var mouse_busy: bool = false
var obstructions: int = 0


## get parent components
func init(_parent: Area2D) -> void:
	parent = _parent
	GlobalScripts.connect_signal(parent, "area_entered", self, "_on_area_entered")
	GlobalScripts.connect_signal(parent, "area_exited", self, "_on_area_exited")
	GlobalScripts.connect_signal(parent, "mouse_entered", self, "_on_mouse_entered")
	GlobalScripts.connect_signal(parent, "mouse_exited", self, "_on_mouse_exited")


## tell tower it has been built
func confirm_build() -> void:
	tower_placed.emit()


## quick check to see if there are any colliding obstacles
func has_obstructions() -> bool:
	if obstructions > 0:
		return true
	return false


## if the preview tower is colliding with something (which can only be obstacles or other towers),
## keep track of it and add 1 to the count
func _on_area_entered(_area: Area2D) -> void:
	obstructions += 1


## if the preview tower stops colliding,
## keep track of it and subtract 1 from the count
func _on_area_exited(_area: Area2D) -> void:
	obstructions -= 1


## if mouse is over the parent
func _on_mouse_entered() -> void:
	mouse_hovering = true


## if the mouse moves somewhere else
func _on_mouse_exited() -> void:
	mouse_hovering = false
