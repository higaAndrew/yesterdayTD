class_name AttackInteractionsComponent
extends Node
##TODO desc


var parent: Area2D
var can_hit_flying: bool = false


## set range values according to stats
func init(_parent: Area2D) -> void:
	parent = _parent
	can_hit_flying = parent.stats.can_hit_flying


func inherit_interactions(parent_interactions: AttackInteractionsComponent) -> void:
	can_hit_flying = parent_interactions.can_hit_flying


func determine_target(target: Area2D) -> bool:
	if not can_hit_flying and target.properties.flying:
		return false
	return true
