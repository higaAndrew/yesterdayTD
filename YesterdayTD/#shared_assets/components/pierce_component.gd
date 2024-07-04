class_name PierceComponent
extends Node

## FIXME pierce cooldown
signal pierce_depleted

var parent: Area2D
var base_pierce: int
var current_pierce: int
var base_pierce_cooldown: float
var current_pierce_cooldown: float
var pierce_active: bool = true
var pierce_expended: bool = false
var hit_list: Array


## set pierce values according to stats
func init(_parent: Area2D) -> void:
	parent = _parent
	base_pierce = parent.stats.base_pierce
	current_pierce = base_pierce
	base_pierce_cooldown = parent.stats.base_pierce_cooldown
	current_pierce_cooldown = base_pierce_cooldown


## reduce pierce. yup
func reduce_pierce() -> void:
	if not pierce_expended:
		current_pierce -= 1
		
		if current_pierce <= 0:
			pierce_expended = true
			pierce_depleted.emit()


## clean the hitlist of any killed targets
## HACK might want to make more efficient
func clean_hit_list() -> void:
	for item in hit_list:
		if !is_instance_valid(item):
			hit_list.erase(item)
