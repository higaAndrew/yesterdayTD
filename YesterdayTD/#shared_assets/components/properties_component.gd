class_name PropertiesComponent
extends Node


var parent: Area2D
var flying: bool = false


## set range values according to stats
func init(_parent: Area2D) -> void:
	parent = _parent
	flying = parent.stats.flying


func toggle_flying() -> void:
	flying = not flying
