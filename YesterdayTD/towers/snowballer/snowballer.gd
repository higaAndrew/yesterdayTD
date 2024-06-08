class_name Snowballer
extends Area2D

@export var stats: TowerStats


@onready var state_machine := $StateMachine as StateMachine
@onready var hitbox := $Hitbox as CollisionShape2D
@onready var detection_range := $DetectionRange as Area2D
@onready var animations := $Animations as AnimatedSprite2D
@onready var sightline := $Sightline as RayCast2D
@onready var targets := $TargetsComponent as TargetsComponent
@onready var range_component := $RangeComponent as RangeComponent


func _ready() -> void:
	GlobalScripts.verify(self, stats, "stats")
	
	state_machine.init(self)
	targets.init(self)
	range_component.init(self)
