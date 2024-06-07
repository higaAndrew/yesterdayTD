@tool
extends Node

@export var stats: TowerStats


func _process(delta) -> void:
	if Engine.is_editor_hint():
		get_parent().shape.radius = stats.base_range
