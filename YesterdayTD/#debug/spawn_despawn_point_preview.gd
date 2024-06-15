@tool
extends Node

@export var hitbox: CollisionShape2D
@export var spawn_point: Marker2D
@export var despawn_point: Area2D


## see the range and sightline update in the editor
func _physics_process(_delta) -> void:
	if Engine.is_editor_hint():
		spawn_point.position = Vector2(hitbox.shape.radius, 0)
		despawn_point.position = Vector2(-hitbox.shape.radius, 0)
