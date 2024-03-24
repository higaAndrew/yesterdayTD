class_name AimComponent
extends RayCast2D

@export var rotation_speed := 10.0
@export var targeting_component: TargetingComponent

@onready var attacker := $"../" as Node2D

func rotate_towards_target(delta: float) -> void:
	# check to see if there are targets
	# if there are, rotate towards them
	if not targeting_component.targets.is_empty():
		var target_position: Vector2 = targeting_component.targets.front().global_position
		var target_rotation: float = global_position.direction_to(target_position).angle()
		attacker.rotation = lerp_angle(attacker.rotation, target_rotation, rotation_speed * delta)
