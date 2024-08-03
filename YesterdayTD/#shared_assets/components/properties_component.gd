class_name PropertiesComponent
extends Node


@export var shadow: Sprite2D

var parent: Area2D
var flying: bool = false


## set range values according to stats
func init(_parent: Area2D) -> void:
	parent = _parent
	flying = parent.stats.flying


## turn on/off flying property
func toggle_flying() -> void:
	flying = not flying


## turn the shadow sprite on/off
func toggle_shadow() -> void:
	GlobalScripts.verify(parent, shadow, "shadow")
	
	shadow.set_visible(false)
