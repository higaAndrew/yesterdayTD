@tool
class_name SpawnDespawnPointPreview
extends Node
## ONLY USE AS CHILD OF ENEMY HITBOX

@export var spawn_point: Marker2D
@export var despawn_point: Area2D


## see the range and sightline update in the editor
func _physics_process(_delta) -> void:
	if Engine.is_editor_hint():
		spawn_point.position = Vector2(get_parent().shape.radius, 0)
		despawn_point.position = Vector2(-get_parent().shape.radius, 0)
