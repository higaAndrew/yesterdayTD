class_name FlyingPiston
extends Piston


@onready var layers := $LayersComponent as LayersComponent


# init state machine and components
func _ready() -> void:
	GlobalScripts.verify(self, stats, "stats")
	
	coin_value.init(self)
	damage.init(self)
	health.init(self)
	hit_flash.init(self)
	layers.init(self)
	path_movement.init(self)
	properties.init(self)
	sound.init(self)
	speed.init(self)
	state_machine.init(self)
