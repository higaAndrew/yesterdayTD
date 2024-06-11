class_name Snowballer
extends Area2D

@export var stats: TowerStats
@export var snowball_scene: PackedScene
@export var attack0_stats: ProjectileStats

@onready var detection_range := $DetectionRange as Area2D
@onready var animations := $Animations as AnimatedSprite2D
@onready var muzzle := $Animations/Muzzle as Marker2D
@onready var sightline := $Sightline as RayCast2D
@onready var state_machine := $StateMachine as StateMachine
@onready var targets := $TargetsComponent as TargetsComponent
@onready var range_component := $RangeComponent as RangeComponent

@onready var snowball_state_machine := $SnowballStateMachine as StateMachine
@onready var snowball_cooldown_timer := $SnowballCooldownTimer as Timer
@onready var snowball_attack := $SnowballAttackComponent as AttackComponent


## init state machines and components
func _ready() -> void:
	GlobalScripts.verify(self, stats, "stats")
	GlobalScripts.verify(self, snowball_scene, "snowball_scene")
	GlobalScripts.verify(self, attack0_stats, "attack0_stats")
	
	state_machine.init(self)
	snowball_state_machine.init(self)
	targets.init(self)
	range_component.init(self)
	snowball_attack.init(self)
