extends State
##TODO descriptions


var tower_builder: TowerBuilderComponent


func init() -> void:
	tower_builder = parent.tower_builder
	
	for tower in parent.tower_list.get_children():
		GlobalScripts.connect_signal_variant(tower, "pressed", self, "_on_tower_button_pressed", tower.name)


func _on_tower_button_pressed(tower_name: String) -> void:
	if not current_state():
		return
	
	tower_builder.set_current_tower(tower_name)
	transitioned.emit(self, "HUDBuilding")
