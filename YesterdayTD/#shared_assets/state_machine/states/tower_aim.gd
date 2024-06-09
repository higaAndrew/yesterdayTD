class_name TowerAim
extends State

var sightline: RayCast2D
var targets: TargetsComponent

var rotation_speed: float
var target_priority: String
var target: Area2D
var target_rotation: float


##  get parent's components
func init() -> void:
	sightline = parent.sightline
	targets = parent.targets
	rotation_speed = parent.stats.base_rotation_speed
	target_priority = parent.stats.target_priority


## every physics frame, sort the list of targets according to target priority
## and rotate towards the first target
func physics_process(delta: float) -> void:
	if not targets.target_list.is_empty():
		targets.target_priority(target_priority)
		target = targets.target_list.front()
		target_rotation = parent.global_position.angle_to_point(target.global_position)
		parent.rotation = lerp_angle(parent.rotation, target_rotation, rotation_speed * delta)
	else:
		transitioned.emit(self, "TowerIdle")
