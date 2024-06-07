class_name TowerIdle
extends State

var detection_range: Area2D
var targets: TargetsComponent


func init() -> void:
	targets = parent.targets
	detection_range = parent.detection_range
	
	GlobalScripts.verify(parent, targets, "targets")
	GlobalScripts.connect_signal(detection_range, "area_entered", self, "_on_detection_range_area_entered")
	GlobalScripts.connect_signal(detection_range, "area_exited", self, "_on_detection_range_area_exited")


func physics_process(_delta: float) -> void:
	if not targets.target_list.is_empty():
		transitioned.emit(self, "TowerAim")


func _on_detection_range_area_entered(area: Area2D) -> void:
	targets.add_target(area)


func _on_detection_range_area_exited(area: Area2D) -> void:
	targets.remove_target(area)
