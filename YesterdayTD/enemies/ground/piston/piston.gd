class_name Piston
extends Area2D

@export var stats: EnemyStats

@onready var state_machine := $StateMachine as StateMachine
@onready var health := $Health as Health
@onready var speed := $Speed as Speed

@onready var path_movement := $PathMovement as PathMovement


## init statemachine and components
func _ready() -> void:
	state_machine.init(self)
	health.init(self)
	speed.init(self)
