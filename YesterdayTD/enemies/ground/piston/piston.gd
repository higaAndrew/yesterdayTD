class_name Piston
extends Area2D

@export var stats: EnemyStats

@onready var state_machine := $StateMachine as StateMachine
@onready var animations := $Animations as AnimatedSprite2D
@onready var damage := $DamageComponent as DamageComponent
@onready var health := $HealthComponent as HealthComponent
@onready var speed := $SpeedComponent as SpeedComponent
@onready var path_movement := $PathMovementComponent as PathMovementComponent


# init state machine and components
func _ready() -> void:
	GlobalScripts.verify(self, stats, "stats")

	state_machine.init(self)
	damage.init(self)
	health.init(self)
	speed.init(self)
	path_movement.init(self)
