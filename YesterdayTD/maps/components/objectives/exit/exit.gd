class_name Exit
extends Objective


@export var stats: ObjectiveStats

@onready var hitbox := $Hitbox as Hitbox
@onready var state_machine := $StateMachine as StateMachine
@onready var health := $HealthComponent as HealthComponent
@onready var sound := $SoundComponent as SoundComponent


## init state machine and components
func _ready() -> void:
	GlobalScripts.verify(self, stats, "stats")

	health.init(self)
	sound.init(self)
	state_machine.init(self)
