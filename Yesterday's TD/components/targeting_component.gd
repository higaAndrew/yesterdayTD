class_name TargetingComponent
extends Node2D

@export var range_component: RangeComponent

var targets: Array[Node2D]


# initializing properties and connecting signals
func _ready() -> void:
	range_component.body_target_entered.connect(_add_body_target)
	range_component.body_target_exited.connect(_remove_body_target)
	range_component.area_target_entered.connect(_add_area_target)
	range_component.area_target_exited.connect(_remove_area_target)


# add a Node2D to the target list
func _add_body_target(target: Node2D) -> void:
	if target not in targets:
		targets.append(target)


# remove a Node2D from the target list
func _remove_body_target(target: Node2D) -> void:
	if target in targets:
		targets.erase(target)


# add an Area2D to the target list
func _add_area_target(target: Area2D) -> void:
	if target not in targets:
		targets.append(target)


# remove an Area2D from the target list
func _remove_area_target(target: Area2D) -> void:
	if target in targets:
		targets.erase(target)
