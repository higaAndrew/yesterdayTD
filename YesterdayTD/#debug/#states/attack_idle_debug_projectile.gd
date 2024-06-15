extends State

var targets: TargetsComponent
var sightline: RayCast2D


## fetch the target list
func init() -> void:
	targets = parent.targets
	sightline = parent.sightline


## if there are targets in range, transition to throw state
func physics_process(delta: float) -> void:
	if not targets.target_list.is_empty() and sightline.is_colliding():
		transition.emit(self, "AttackThrowDebugProj")
