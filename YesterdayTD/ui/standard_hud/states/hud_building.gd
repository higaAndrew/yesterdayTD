extends State
## TODO dynamic drag and drop


var tower_builder: TowerBuilderComponent


## get parent components
func init() -> void:
	tower_builder = parent.tower_builder


## every loop, set up a build preview
func loop() -> void:
	tower_builder.set_build_preview()


## every physics frame, update the build preview
func physics_process(_delta: float) -> void:
	tower_builder.update_build_preview()


## handle input interaction
func _unhandled_input(event: InputEvent) -> void:
	if not current_state():
		return
	
	# if the tower is clicked on
	# check if the location is valid, and that a valid tower preview exists
	# if so, then build the tower and transition to idle state
	if event.is_action_released("ui_accept"):
		if tower_builder.valid_location and is_instance_valid(tower_builder.tower_preview):
			tower_builder.build_tower()
			tower_builder.play_build_sound()
			MoneyManager.decrease_coins(tower_builder.tower_preview.stats.base_price)
			tower_builder.reset_tower_preview()
			
			transitioned.emit(self, "HUDIdle")
	
	# if esc is pressed, cancel the build and transition to idle state
	elif event.is_action("ui_cancel"):
		tower_builder.cancel_build()
		transitioned.emit(self, "HUDIdle")
