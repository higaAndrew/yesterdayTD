class_name Snowball
extends Area2D

@export var stats: ProjectileStats

@onready var damage := $DamageComponent as DamageComponent
@onready var pierce := $PierceComponent as PierceComponent
@onready var speed := $SpeedComponent as SpeedComponent


## init state machine and components
func _ready() -> void:
	damage.init(self)
	pierce.init(self)
	speed.init(self)
