class_name SnowBomber
extends StaticBody2D

@onready var aim_component := $AimComponent as AimComponent
@onready var attack_component := $AttackComponent as AttackComponent


func _ready() -> void:
	rotation_degrees = 90


func _physics_process(delta: float) -> void:
	attack_component.aim_and_attack(delta)


func _on_attack_component_attacking() -> void:
	attack_component.throw_projectile_attack("snowbomb")
