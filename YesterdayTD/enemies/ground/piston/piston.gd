class_name Piston
extends Area2D

@export var stats: EnemyStats
@export var hello: Stats

@onready var state_machine := $StateMachine as StateMachine
@onready var health := $HealthComponent as HealthComponent
@onready var speed := $SpeedComponent as SpeedComponent
@onready var path_movement := $PathMovementComponent as PathMovementComponent


## init statemachine and components
func _ready() -> void:
	if not is_instance_valid(stats):
		printerr("Piston is missing stats(EnemyStats)!")
		return
	GlobalScripts.verify(self, hello, "hello")

	state_machine.init(self)
	health.init(self)
	speed.init(self)
