extends State
##TODO desc

var detection_range: Area2D
var range_hitbox: CollisionShape2D
var targets: TargetsComponent

var mouse_hovering: bool = false


## get parent's components
func enter() -> void:
	detection_range = parent.detection_range
	targets = parent.targets
	
	range_hitbox = detection_range.find_child("RangeHitbox")
	GlobalScripts.verify(parent, range_hitbox, "range_hitbox")
	
	GlobalScripts.connect_signal(parent, "mouse_entered", self, "_on_mouse_entered")
	GlobalScripts.connect_signal(parent, "mouse_exited", self, "_on_mouse_exited")
	
	range_hitbox.set_visible(true)


func _on_mouse_entered() -> void:
	if not current_state():
		return
	
	mouse_hovering = true


func _on_mouse_exited() -> void:
	if not current_state():
		return
	
	mouse_hovering = false


func _unhandled_input(event: InputEvent) -> void:
	if not current_state():
		return
	
	if event.is_action_released("ui_accept"):
		if mouse_hovering:
			range_hitbox.set_visible(!range_hitbox.visible)
			transitioned.emit(self, "TowerIdle")
