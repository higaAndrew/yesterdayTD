class_name Snowball
extends Area2D

@onready var projectile_behavior_component := $ProjectileBehaviorComponent as ProjectileBehaviorComponent

var speed: int
var damage: int
var velocity: Vector2
var projectile_penetration: int
var vfx_finished := false
var sound_finished := false


func start(_position: Vector2, _rotation: float, _speed: int, _damage: int, _scale: float, _projectile_penetration: int, _aim_component_position: Vector2) -> void:
	projectile_behavior_component.initialize_throw_behavior(_position, _rotation, _speed, _damage, _scale, _projectile_penetration, _aim_component_position)


func _physics_process(delta: float) -> void:
	projectile_behavior_component.update_throw_velocity(delta)


func _hit() -> void:
	projectile_behavior_component.throw_hit()


func _on_hit_vfx_animation_finished() -> void:
	vfx_finished = true
	projectile_behavior_component.throw_finished(vfx_finished, sound_finished)


func _on_hit_sound_finished() -> void:
	sound_finished = true
	projectile_behavior_component.throw_finished(vfx_finished, sound_finished)


func _on_body_entered(body: Node2D) -> void:
	projectile_behavior_component.body_entered(body)


func _on_lifespan_timer_timeout() -> void:
	projectile_behavior_component.despawn()
