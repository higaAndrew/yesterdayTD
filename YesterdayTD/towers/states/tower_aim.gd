extends State
## obsolete, towers now aim immediately, only when shooting
## this simplifies physics a bit and balances accuracy around projectile speed

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
	target = targets.target


## every physics frame, sort the list of targets according to target priority
## and rotate towards the first target
func physics_process(_delta: float) -> void:
	if not targets.target_list.is_empty():
		targets.get_target(target_priority)
		target = targets.target
		# snap to enemy (adjusted for arm)
		#target_rotation = parent.global_position.angle_to_point(target.global_position)-0.15
		# snap to enemy
		target_rotation = parent.global_position.angle_to_point(target.global_position)
		# lerp rotate towards enemy
		#parent.rotation = lerp_angle(parent.rotation, target_rotation, rotation_speed * delta)
		parent.rotation = target_rotation
	else:
		transitioned.emit(self, "TowerIdle")
