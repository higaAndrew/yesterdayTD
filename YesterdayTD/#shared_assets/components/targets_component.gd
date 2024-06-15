class_name TargetsComponent
extends Node


var parent: Area2D
var target_list: Array


## set targets values according to stats
func init(_parent: Area2D) -> void:
	parent = _parent


## add a target to the list
func add_target(target: Area2D) -> void:
	if target not in target_list:
		target_list.append(target)
		target_priority("First")


## remove a target from the list
func remove_target(target: Area2D) -> void:
	if target in target_list:
		target_list.erase(target)


## use the sorting algorithm specified by the targeting priority
func target_priority(priority: String) -> void:
	match priority:
		"First":
			target_list.sort_custom(sort_first)
		"Last":
			target_list.sort_custom(sort_last)
		"Strong":
			target_list.sort_custom(sort_strong)
		"Weak":
			target_list.sort_custom(sort_weak)
		"Close":
			target_list.sort_custom(sort_close)
		"Random":
			# doesn't need sorting
			pass


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


## prioritize targets randomly
## NOTE: this feels dangerous and unstable but it's quite funny so i'm keeping it
func sort_random(_a, _b) -> bool:
	var coin = randi_range(0, 1)
	if coin == 0:
		return true
	return false
