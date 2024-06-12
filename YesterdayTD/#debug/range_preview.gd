@tool
extends Node

@export var stats: TowerStats
@export var sightline: RayCast2D

## see the range and sightline update in the editor
func _process(delta) -> void:
	if Engine.is_editor_hint():
		get_parent().shape.radius = stats.base_range
		sightline.set_target_position(Vector2(stats.base_range + 100, 0))
