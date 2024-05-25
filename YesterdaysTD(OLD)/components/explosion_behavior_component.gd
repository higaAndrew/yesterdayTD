class_name ExplosionBehaviorComponent
extends Node2D

@export var animated_sprite: AnimatedSprite2D
@export var collision_shape: CollisionShape2D

@onready var explosion := $"../" as Area2D

var enemies_hit: Array[int]


# initialize explosion properties
func initialize_explosion_behavior(_position: Vector2, _rotation: float, _damage: int, _scale: float, _pierce: int) -> void:
	explosion.global_position = _position
	explosion.rotation = _rotation
	explosion.damage = _damage
	explosion.scale = Vector2(_scale, _scale)
	explosion.pierce = _pierce


# disable damage
func end_damage_window() -> void:
	collision_shape.set_deferred("disabled", true)


# enable damage
func open_damage_window() -> void:
	collision_shape.set_deffered("diabled", false)


# delete when animation and sound are finished
func explosion_finished(animation_finished: bool, sound_finished: bool) -> void:
	if animation_finished and sound_finished:
		despawn()


# if entity enters explosion radius
func body_entered(enemy: Node2D) -> void:
	# if entity is enemy
	# and explosion still has remaining pierce
	if enemy.is_in_group("enemy"):
		print("enemy!")
		print(explosion.pierce)
	if enemy.is_in_group("enemy") and explosion.pierce > 0 and enemy not in enemies_hit:
		enemies_hit.append(enemy)
		enemy.health_component.take_damage(explosion.damage)
		_reduce_pierce()
		print("ay im walkin here")


# delete
func despawn() -> void:
	explosion.queue_free()


# reduce available pierce
func _reduce_pierce() -> void:
	explosion.pierce -= 1
