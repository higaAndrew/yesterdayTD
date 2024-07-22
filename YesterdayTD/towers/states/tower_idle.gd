extends State
##TODO desc

var detection_range: Area2D
var range_hitbox: CollisionShape2D
var targets: TargetsComponent

var mouse_hovering: bool = true


## get parent's components
func init() -> void:
	detection_range = parent.detection_range
	targets = parent.targets
	
	range_hitbox = detection_range.find_child("RangeHitbox")
	GlobalScripts.verify(parent, range_hitbox, "range_hitbox")
	
	GlobalScripts.connect_signal(parent, "mouse_entered", self, "_on_mouse_entered")
	GlobalScripts.connect_signal(parent, "mouse_exited", self, "_on_mouse_exited")
	GlobalScripts.connect_signal(detection_range, "area_entered", self, "_on_detection_range_area_entered")
	GlobalScripts.connect_signal(detection_range, "area_exited", self, "_on_detection_range_area_exited")
	
	range_hitbox.set_visible(false)


## when enemy collides with range, add it to the target list
## constantly running
func _on_detection_range_area_entered(area: Area2D) -> void:
	if not current_state():
		return
	
	targets.add_target(area)


## when enemy stops colliding with range, remove it from the target list
## constantly running
func _on_detection_range_area_exited(area: Area2D) -> void:
	if not current_state():
		return
	
	targets.remove_target(area)


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
		elif range_hitbox.visible:
			range_hitbox.set_visible(false)
	
	
