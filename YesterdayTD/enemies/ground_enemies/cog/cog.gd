class_name Cog
extends Area2D

@export var stats: EnemyStats
@export var starting_progress := 0.0

@onready var hitbox := $Hitbox as Hitbox
@onready var animations := $Animations as AnimatedSprite2D
@onready var hurt_sound := $HurtSound as AudioStreamPlayer
@onready var death_sound := $DeathSound as AudioStreamPlayer
@onready var state_machine := $StateMachine as StateMachine
@onready var damage := $DamageComponent as DamageComponent
@onready var health := $HealthComponent as HealthComponent
@onready var path_movement := $PathMovementComponent as PathMovementComponent
@onready var speed := $SpeedComponent as SpeedComponent

var progenitor_attack: Area2D


# init state machine and components
func _ready() -> void:
	GlobalScripts.verify(self, stats, "stats")

	state_machine.init(self)
	damage.init(self)
	health.init(self)
	path_movement.init(self)
	speed.init(self)
