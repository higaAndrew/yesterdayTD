class_name TowerAim
extends State

var sightline: RayCast2D
var targets: TargetsComponent
var rotation_speed: float
var target: Area2D
var target_position: Vector2
var target_rotation: float
var target_priority: String

func init() -> void:
	sightline = parent.sightline
	targets = parent.targets
	rotation_speed = parent.stats.base_rotation_speed
	target_priority = parent.stats.target_priority
	
	GlobalScripts.verify(parent, targets, "targets")


func physics_process(delta: float) -> void:
	if not targets.target_list.is_empty():
		targets.target_priority(target_priority)
		target = targets.target_list.front()
		target_position = target.global_position
		target_rotation = parent.global_position.angle_to_point(target_position)
		parent.rotation = lerp_angle(parent.rotation, target_rotation, rotation_speed * delta)
	else:
		transitioned.emit(self, "TowerIdle")
		print("yay")
