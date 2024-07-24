extends State


var range_hitbox: Hitbox
var outline: OutlineComponent
var ui: UIComponent


## get parent's components
func enter() -> void:
	range_hitbox = parent.range_hitbox
	outline = parent.outline
	
	ui = parent.ui
	GlobalScripts.connect_signal(ui, "tower_placed", self, "_on_tower_placed")
	
	GlobalScripts.connect_signal(parent, "mouse_entered", self, "_on_mouse_entered")
	GlobalScripts.connect_signal(parent, "mouse_exited", self, "_on_mouse_exited")
	
	# show the range but disable it
	range_hitbox.reveal_hitbox()
	range_hitbox.disable_hitbox()
	outline.enable_outline()


## when the tower is placed, transition to idle state
func _on_tower_placed() -> void:
	if not current_state():
		return
	
	transitioned.emit(self, "TowerIdle")
