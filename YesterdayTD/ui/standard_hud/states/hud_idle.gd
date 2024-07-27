extends State


var tower_builder: TowerBuilderComponent


## get parent components
func init() -> void:
	tower_builder = parent.tower_builder
	
	# connect each button's pressed signal
	for tower_button in parent.tower_list.get_children():
		GlobalScripts.connect_signal_object(tower_button, "pressed", self, "_on_tower_button_pressed", tower_button)


## if a button is pressed, set tower builder component's current tower to the tower on the button
## then transition to building state
func _on_tower_button_pressed(tower_button: Button) -> void:
	if not current_state():
		return
	
	# originally i had a check here to see if the player had enough money to purchase the tower before changing state,
	# but then i realized that i could just check that in the button and disable it there, simplifying things immensely
	tower_builder.set_current_tower(tower_button.tower_name)
	transitioned.emit(self, "HUDBuilding")
