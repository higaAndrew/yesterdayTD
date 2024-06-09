class_name Snowballer
extends Area2D

@export var stats: TowerStats

@onready var detection_range := $DetectionRange as Area2D
@onready var animations := $Animations as AnimatedSprite2D
@onready var sightline := $Sightline as RayCast2D

@onready var state_machine := $StateMachine as StateMachine
@onready var attack_state_machine := $AttackStateMachine as StateMachine
@onready var targets := $TargetsComponent as TargetsComponent
@onready var range_component := $RangeComponent as RangeComponent


## init state machines and components
func _ready() -> void:
	GlobalScripts.verify(self, stats, "stats")
	
	state_machine.init(self)
	attack_state_machine.init(self)
	targets.init(self)
	range_component.init(self)
