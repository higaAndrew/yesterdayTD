class_name TargetsComponent
extends Node

@export var range_hitbox: CollisionShape2D

var parent: Node2D
var target_list := []


## set targets values according to stats
func init(_parent: Node2D) -> void:
	parent = _parent


## add a target to the list
func add_target(target: Area2D) -> void:
	if target not in target_list and target.is_in_group("enemies"):
		target_list.append(target)


## remove a target from the list
func remove_target(target: Area2D) -> void:
	if target in target_list:
		target_list.erase(target)
