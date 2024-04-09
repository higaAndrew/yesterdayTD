class_name ProjectileBehaviorComponent
extends Node2D

@export var animated_sprite: AnimatedSprite2D
@export var collision_shape: CollisionShape2D
@export var hit_vfx: AnimatedSprite2D
@export var hit_sound: AudioStreamPlayer

@onready var projectile := $"../" as Area2D


func initialize_throw_behavior(_position: Vector2, _rotation: float, _speed: int, _damage: int, _scale: float, _projectile_penetration: int, _aim_component_position: Vector2) -> void:
	projectile.global_position = _position
	projectile.rotation = _rotation
	projectile.speed = _speed
	projectile.damage = _damage

	# calculate direction vector to aim_component
	var direction = (_aim_component_position - _position).normalized()

	#projectile.velocity = Vector2.RIGHT.rotated(_rotation) * projectile.speed
	projectile.velocity = direction * projectile.speed
	projectile.scale = Vector2(_scale, _scale)
	projectile.projectile_penetration = _projectile_penetration


func update_throw_velocity(delta: float) -> void:
	projectile.global_position += projectile.velocity * delta


func throw_hit() -> void:
	projectile.set_physics_process(false)
	collision_shape.set_deferred("disabled", true)
	animated_sprite.hide()
	hit_vfx.show()
	hit_vfx.play("hit")
	hit_sound.play()


func throw_finished(vfx_finished: bool, sound_finished: bool) -> void:
	if vfx_finished and sound_finished:
		despawn()


func body_entered(enemy: Node2D) -> void:
	if enemy.is_in_group("enemy") and projectile.projectile_penetration > 0:
		enemy.health_component.take_damage(projectile.damage)
		_reduce_penetration()
		throw_hit()

func despawn() -> void:
	projectile.queue_free()


func _reduce_penetration() -> void:
	projectile.projectile_penetration -= 1
