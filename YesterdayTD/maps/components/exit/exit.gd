class_name Exit
extends Area2D

@export var stats: Stats

@onready var state_machine := $StateMachine as StateMachine
@onready var hitbox := $Hitbox as CollisionShape2D
@onready var health := $HealthComponent as HealthComponent



## init state machine and components
func _ready() -> void:
	GlobalScripts.verify(self, stats, "stats")

	state_machine.init(self)
	health.init(self)
