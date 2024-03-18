class_name Piston
extends CharacterBody2D

@onready var health_component := $HealthComponent as HealthComponent
@onready var damage_component := $DamageComponent as DamageComponent

func _ready() -> void:
	health_component.initialize_health()
