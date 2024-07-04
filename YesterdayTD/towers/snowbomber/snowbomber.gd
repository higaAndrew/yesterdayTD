class_name Snowbomber
extends Area2D


@export var stats: TowerStats

@export_group("Attacks")
@export_subgroup("Attack0")
@export var attack0_scene: PackedScene
@export var attack0_stats: AttackStats
@onready var attack0_cooldown_timer := $SnowbombCooldownTimer as Timer

@onready var detection_range := $DetectionRange as Area2D
@onready var animations := $Animations as AnimatedSprite2D
@onready var sightline := $Sightline as RayCast2D
@onready var state_machine := $StateMachine as StateMachine
@onready var snowbomb_state_machine := $SnowbombStateMachine as StateMachine
@onready var attack := $AttackComponent as AttackComponent
@onready var cooldown := $CooldownComponent as CooldownComponent
@onready var range_component := $RangeComponent as RangeComponent
@onready var targets := $TargetsComponent as TargetsComponent


## init state machines and components
func _ready() -> void:
	GlobalScripts.verify(self, stats, "stats")
	GlobalScripts.verify(self, attack0_scene, "snowbomb_scene")
	GlobalScripts.verify(self, attack0_stats, "attack0_stats")
	
	state_machine.init(self)
	snowbomb_state_machine.init(self)
	attack.init(self)
	cooldown.init(self)
	range_component.init(self)
	targets.init(self)