extends State


var detection_range: Area2D
var attack_interactions: AttackInteractionsComponent
var outline: OutlineComponent
var range_hitbox: Hitbox
var targets: TargetsComponent
var ui: UIComponent


## get parent's components
func init() -> void:
	attack_interactions = parent.attack_interactions
	targets = parent.targets
	outline = parent.outline
	ui = parent.ui
	
	detection_range = parent.detection_range
	GlobalScripts.connect_signal(detection_range, "area_entered", self, "_on_detection_range_area_entered")
	GlobalScripts.connect_signal(detection_range, "area_exited", self, "_on_detection_range_area_exited")
	
	range_hitbox = parent.range_hitbox
	GlobalScripts.verify(parent, range_hitbox, "range_hitbox")
	
	GlobalScripts.connect_signal(parent, "mouse_entered", self, "_on_mouse_entered")
	GlobalScripts.connect_signal(parent, "mouse_exited", self, "_on_mouse_exited")
	
	range_hitbox.hide_hitbox()
	range_hitbox.enable_hitbox()
	outline.disable_outline()


# when enemy collides with range, add it to the target list
# constantly running
func _on_detection_range_area_entered(area: Area2D) -> void:
	if attack_interactions.determine_target(area):
		targets.add_target(area)
	else:
		return


# when enemy stops colliding with range, remove it from the target list
# constantly running
func _on_detection_range_area_exited(area: Area2D) -> void:
	targets.remove_target(area)


## handle input interaction
func _unhandled_input(event: InputEvent) -> void:
	if not current_state():
		return
	
	# if clicked
	# toggle if tower is clicked on, hide hitbox if not
	if event.is_action_released("ui_accept"):
		if ui.mouse_hovering and not ui.has_obstructions():
			range_hitbox.toggle_hitbox_visibility()
			outline.toggle_outline()
		elif range_hitbox.hitbox_visible:
			range_hitbox.hide_hitbox()
			outline.disable_outline()
	
	# if cancel is pressed, hide hitbox if it was visible
	if event.is_action_released("ui_cancel"):
		if range_hitbox.hitbox_visible:
			range_hitbox.hide_hitbox()
			outline.disable_outline()
