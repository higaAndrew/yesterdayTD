class_name ProjectileBehaviorComponent
extends Node2D

@export var animated_sprite: AnimatedSprite2D
@export var collision_shape: CollisionShape2D
@export var hit_vfx: AnimatedSprite2D
@export var hit_sound: AudioStreamPlayer

@onready var projectile := $"../" as Area2D

var map: Node2D
var explosionPath: CanvasLayer


# locate parent map for spawning projectiles
func _ready() -> void:
	map = find_parent("Map")
	explosionPath = map.find_child("Effects")



# initialize explosion properties
func initialize_projectile_behavior(_position: Vector2, _rotation: float, _speed: int, _damage: int, _scale: float, _pierce: int, _aim_component_position: Vector2) -> void:
	projectile.global_position = _position
	projectile.rotation = _rotation
	projectile.speed = _speed
	projectile.damage = _damage
	# calculate direction vector to aim component
	var direction = (_aim_component_position - _position).normalized()
	# projectile.velocity = Vector2.RIGHT.rotated(_rotation) * projectile.speed
	projectile.velocity = direction * projectile.speed
	projectile.scale = Vector2(_scale, _scale)
	projectile.pierce = _pierce


# update the current velocity of the projectile
func update_projectile_velocity(delta: float) -> void:
	projectile.global_position += projectile.velocity * delta


# when projectile hits entity
func projectile_hit() -> void:
	projectile.set_physics_process(false)
	collision_shape.set_deferred("disabled", true)
	animated_sprite.hide()
	hit_vfx.show()
	hit_vfx.play("hit")
	hit_sound.play()


# when explosive hits enemy
func explosive_hit() -> void:
	projectile.set_physics_process(false)
	collision_shape.set_deferred("disabled", true)
	animated_sprite.hide()
	hit_vfx.show()


# if animations and sound are finished, despawn
func projectile_finished(vfx_finished: bool, sound_finished: bool) -> void:
	if vfx_finished and sound_finished:
		despawn()


# if explosive (not explosion) animations are finished, despawn (the explosive)
func projectile_finished_explosive(vfx_finished: bool) -> void:
	despawn()


# if projectile collides with entity
func body_entered(enemy: Node2D) -> void:
	if enemy.is_in_group("enemy") and projectile.pierce > 0:
		enemy.health_component.take_damage(projectile.damage)
		_reduce_pierce()
		projectile_hit()


# if explosive (not explosion) collides with entity
func body_entered_explosive(enemy: Node2D, explosion_type: PackedScene) -> void:
	if enemy.is_in_group("enemy") and projectile.pierce > 0:
		_reduce_pierce()
		explosive_hit()
		create_explosion(explosion_type)


# delete
func despawn() -> void:
	projectile.queue_free()


# spawn explosion at the explosive
func create_explosion(explosion_type: PackedScene) -> void:
	var explosion: Area2D = explosion_type.instantiate()
	if is_instance_valid(explosionPath):
		explosionPath.add_child(explosion)
	else:
		owner.add_child(explosion)
	explosion.start(projectile.position, projectile.rotation, projectile.damage, projectile.explosive_scale, projectile.pierce)


# reduce available pierce
func _reduce_pierce() -> void:
	projectile.pierce -= 1
