extends State

var targets: TargetsComponent
var sightline: RayCast2D


## fetch the target list
func init() -> void:
	targets = parent.targets
	sightline = parent.sightline


## if there are targets in range, transition to throw state
func physics_process(_delta: float) -> void:
	if not targets.target_list.is_empty():
		transitioned.emit(self, "AttackThrowSnowball")
