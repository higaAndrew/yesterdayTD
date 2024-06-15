class_name DebugTower
extends Area2D

@export var stats: TowerStats
@export var attack0_scene: PackedScene
@export var attack0_stats: AttackStats

@onready var detection_range := $DetectionRange as Area2D
@onready var animations := $Animations as AnimatedSprite2D
@onready var muzzle := $Animations/Muzzle as Marker2D
@onready var sightline := $Sightline as RayCast2D
@onready var state_machine := $StateMachine as StateMachine
@onready var targets := $TargetsComponent as TargetsComponent
@onready var range_component := $RangeComponent as RangeComponent

@onready var debug_projectile_state_machine := $DebugProjStateMachine as StateMachine
@onready var debug_projectile_cooldown_timer := $DebugProjCooldownTimer as Timer
@onready var debug_projectile_attack := $DebugProjAttackComponent as AttackComponent


## init state machines and components
func _ready() -> void:
	GlobalScripts.verify(self, stats, "stats")
	GlobalScripts.verify(self, attack0_scene, "snowball_scene")
	GlobalScripts.verify(self, attack0_stats, "attack0_stats")
	
	state_machine.init(self)
	debug_projectile_state_machine.init(self)
	targets.init(self)
	range_component.init(self)
	debug_projectile_attack.init(self)
