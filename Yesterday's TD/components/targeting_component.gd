class_name TargetingComponent
extends Node2D

@export var range_component: RangeComponent

var targets: Array[Node2D]


func _ready() -> void:
	# connecting signals
	range_component.body_target_entered.connect(_add_body_target)
	range_component.body_target_exited.connect(_remove_body_target)
	range_component.area_target_entered.connect(_add_area_target)
	range_component.area_target_exited.connect(_remove_area_target)



func _add_body_target(target: Node2D) -> void:
	# add a Node2D to the target list
	if target not in targets:
		targets.append(target)


func _remove_body_target(target: Node2D) -> void:
	# remove a Node2D from the target list
	if target in targets:
		targets.erase(target)


func _add_area_target(target: Area2D) -> void:
	# add an Area2D to the target list
	if target not in targets:
		targets.append(target)


func _remove_area_target(target: Area2D) -> void:
	# remove an Area2D from the target list
	if target in targets:
		targets.erase(target)
