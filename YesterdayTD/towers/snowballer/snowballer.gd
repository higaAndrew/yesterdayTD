class_name Snowballer
extends Area2D


@export var stats: TowerStats

@export var attack0_scene: PackedScene
@export var attack0_stats: AttackStats
@onready var attack0_cooldown_timer := $SnowballCooldownTimer as Timer

@onready var detection_range := $DetectionRange as Area2D
@onready var animations := $Animations as AnimatedSprite2D
@onready var sightline := $Sightline as RayCast2D
@onready var state_machine := $StateMachine as StateMachine
@onready var snowball_state_machine := $SnowballStateMachine as AttackStateMachine
@onready var attack := $AttackComponent as AttackComponent
@onready var cooldown := $CooldownComponent as CooldownComponent
@onready var range_component := $RangeComponent as RangeComponent
@onready var targets := $TargetsComponent as TargetsComponent


## init state machines and components
func _ready() -> void:
	GlobalScripts.verify(self, stats, "stats")
	GlobalScripts.verify(self, attack0_scene, "snowball scene")
	GlobalScripts.verify(self, attack0_stats, "snowball stats")
	
	state_machine.init(self)
	snowball_state_machine.init(self)
	attack.init(self)
	cooldown.init(self)
	range_component.init(self)
	targets.init(self)
