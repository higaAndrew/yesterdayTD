class_name AttackInteractionsComponent
extends Node
##TODO desc


var parent: Area2D
var inherits_interactions: bool = true
var can_hit_flying: bool = false


## set range values according to stats
func init(_parent: Area2D) -> void:
	parent = _parent
	inherits_interactions = parent.stats.inherits_interactions
	can_hit_flying = parent.stats.can_hit_flying


func inherit_interactions(parent_interactions: AttackInteractionsComponent) -> void:
	if not inherits_interactions:
		return
	
	can_hit_flying = parent_interactions.can_hit_flying


func determine_target(target: Area2D) -> bool:
	if not can_hit_flying and target.properties.flying:
		return false
	return true
