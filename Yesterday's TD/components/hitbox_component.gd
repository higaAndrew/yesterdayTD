class_name HitboxComponent
extends Area2D

signal enemy_entered(enemy: Node2D)
signal enemy_exited(enemy: Node2D)
signal tower_entered(tower: Node2D)
signal tower_exited(tower: Node2D)

@export var health_component: HealthComponent

@onready var collision_shape: CollisionShape2D= get_child(0)


func enable_collision() -> void:
	collision_shape.set_deferred("disabled", false)


func disable_collision() -> void:
	collision_shape.set_deferred("disabled", true)


func _on_body_entered(body: Node2D) -> void:
	# determine what collided with self
	if body.is_in_group("enemy"):
		enemy_entered.emit(body)
	elif body.is_in_group("tower"):
		tower_entered.emit(body)


func _on_body_exited(body: Node2D) -> void:
	# determine what stopped colliding with selfhow
	if body.is_in_group("enemy"):
		enemy_exited.emit(body)
	elif body.is_in_group("tower"):
		tower_exited.emit(body)
