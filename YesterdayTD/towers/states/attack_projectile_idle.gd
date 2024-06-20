extends State


var targets: TargetsComponent


## fetch the target list
func init() -> void:
	targets = parent.targets


## if there are targets in range, transition to throw state
func physics_process(_delta: float) -> void:
	if not targets.target_list.is_empty():
		transitioned.emit(self, "AttackProjectileThrow")
