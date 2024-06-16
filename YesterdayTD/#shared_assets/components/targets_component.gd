class_name TargetsComponent
extends Node

var parent: Area2D
var target_list: Array
var target: Area2D


## set targets values according to stats
func init(_parent: Area2D) -> void:
	parent = _parent


## add a target to the list
func add_target(area: Area2D) -> void:
	if area not in target_list:
		target_list.append(area)


## remove a target from the list
func remove_target(area: Area2D) -> void:
	if area in target_list:
		target_list.erase(area)


## use the sorting algorithm specified by the targeting priority
func get_target(priority: String) -> void:
	match priority:
		"First":
			target_list.sort_custom(sort_first)
			target = target_list.front()
		"Last":
			target_list.sort_custom(sort_last)
			target = target_list.front()
		"Strong":
			target_list.sort_custom(sort_strong)
			target = target_list.front()
		"Weak":
			target_list.sort_custom(sort_weak)
			target = target_list.front()
		"Close":
			target_list.sort_custom(sort_close)
			target = target_list.front()
		"Random":
			# doesn't need sorting
			target = target_list.pick_random()
		_:
			printerr("%s isn't a sorting priority, how did you even do that" % priority)
			return


## prioritize target with most progress along path
func sort_first(a, b) -> bool:
	if a.path_movement.progress > b.path_movement.progress:
		return true
	return false


## prioritize target with least progress along path
func sort_last(a, b) -> bool:
	if a.path_movement.progress < b.path_movement.progress:
		return true
	return false


## prioritize target with most base health
func sort_strong(a, b) -> bool:
	if a.health.base_health > b.health.base_health:
		return true
	if a.health.base_health == b.health.base_health:
		if a.path_movement.progress > b.path_movement.progress:
			return true
		return false
	return false


## prioritize target with least base health
func sort_weak(a, b) -> bool:
	if a.health.base_health < b.health.base_health:
		return true
	if a.health.base_health == b.health.base_health:
		if a.path_movement.progress > b.path_movement.progress:
			return true
		return false
	return false


## prioritize targets close to the tower
func sort_close(a, b) -> bool:
	if a.global_position.distance_to(parent.global_position) < b.global_position.distance_to(parent.global_position):
		return true
	return false
