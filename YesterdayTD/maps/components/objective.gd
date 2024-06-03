class_name Objective
extends Area2D

@export var stats: ObjectiveStats

@onready var state_machine := $StateMachine as StateMachine
@onready var health := $HealthComponent as HealthComponent

func _ready() -> void:
	GlobalScripts.verify(self, stats, "stats")

	state_machine.init(self)
	health.init(self)
