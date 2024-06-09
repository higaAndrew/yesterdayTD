class_name TowerAttackIdle
extends State

var targets: TargetsComponent

func init() -> void:
	targets = parent.targets


func physics_process(delta: float) -> void:
	if not targets.target_list.is_empty():
		transitioned.emit(self, "TowerAttackThrow")
