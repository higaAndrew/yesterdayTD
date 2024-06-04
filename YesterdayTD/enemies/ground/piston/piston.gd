class_name Piston
extends Area2D

@export var stats: EnemyStats

@onready var state_machine := $StateMachine as StateMachine
@onready var health := $HealthComponent as HealthComponent
@onready var speed := $SpeedComponent as SpeedComponent
@onready var path_movement := $PathMovementComponent as PathMovementComponent


# init statemachine and components
func _ready() -> void:
	GlobalScripts.verify(self, stats, "stats")

	state_machine.init(self)
	health.init(self)
	speed.init(self)
