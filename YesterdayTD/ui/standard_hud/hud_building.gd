extends State
## TODO desc

var tower_builder: TowerBuilderComponent

func init() -> void:
	tower_builder = parent.tower_builder


func loop() -> void:
	tower_builder.set_build_preview()


func physics_process(_delta: float) -> void:
	tower_builder.update_build_preview()


func _unhandled_input(event: InputEvent) -> void:
	if not current_state():
		return

	if event.is_action_released("ui_accept"):
		#if tower_bui
		if tower_builder.valid_location and is_instance_valid(tower_builder.tower_preview):
			tower_builder.build_tower()
			transitioned.emit(self, "HUDIdle")
	
	elif event.is_action_released("ui_cancel"):
		tower_builder.cancel_build()
		transitioned.emit(self, "HUDIdle")
