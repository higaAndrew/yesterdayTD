extends State


var tower_builder: TowerBuilderComponent


## get parent components
func init() -> void:
	tower_builder = parent.tower_builder
	
	# connect each button's pressed signal
	for tower in parent.tower_list.get_children():
		GlobalScripts.connect_signal_variant(tower, "pressed", self, "_on_tower_button_pressed", tower.name)


## if a button is pressed, set tower builder component's current tower to the tower on the button
## then transition to building state
func _on_tower_button_pressed(tower_name: String) -> void:
	if not current_state():
		return
	
	tower_builder.set_current_tower(tower_name)
	transitioned.emit(self, "HUDBuilding")
