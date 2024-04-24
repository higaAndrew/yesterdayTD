class_name ExplosionBehaviorComponent
extends Node2D

@export var animated_sprite: AnimatedSprite2D
@export var collision_shape: CollisionShape2D

@onready var explosion := $"../" as Area2D

var enemies_hit: Array[int]


func initialize_explosion_behavior(_position: Vector2, _rotation: float, _damage: int, _scale: float, _projectile_penetration: int) -> void:
	explosion.global_position = _position
	explosion.rotation = _rotation
	explosion.damage = _damage
	explosion.scale = Vector2(_scale, _scale)
	explosion.projectile_penetration = _projectile_penetration


func end_damage_window() -> void:
	collision_shape.set_deferred("disabled", true)


func open_damage_window() -> void:
	collision_shape.set_deffered("diabled", false)


func explosion_finished(animation_finished: bool, sound_finished: bool) -> void:
	if animation_finished and sound_finished:
		despawn()


func body_entered(enemy: Node2D) -> void:
	if enemy.is_in_group("enemy") and explosion.projectile_penetration > 0 and enemy not in enemies_hit:
		enemies_hit.append(enemy)
		enemy.health_component.take_damage(explosion.damage)
		_reduce_penetration()


func despawn() -> void:
	explosion.queue_free()


func _reduce_penetration() -> void:
	explosion.projectile_penetration -= 1
