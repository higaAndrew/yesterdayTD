extends State


var detection_range: Area2D
var targets: TargetsComponent


## get parent's components
func init() -> void:
	detection_range = parent.detection_range
	
	targets = parent.targets
	GlobalScripts.connect_signal(detection_range, "area_entered", self, "_on_detection_range_area_entered")
	GlobalScripts.connect_signal(detection_range, "area_exited", self, "_on_detection_range_area_exited")


## when enemy collides with range, add it to the target list
## constantly running
func _on_detection_range_area_entered(area: Area2D) -> void:
	targets.add_target(area)


## when enemy stops colliding with range, remove it from the target list
## constantly running
func _on_detection_range_area_exited(area: Area2D) -> void:
	targets.remove_target(area)
