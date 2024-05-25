class_name Snowbomb
extends Area2D

@onready var projectile_behavior_component := $ProjectileBehaviorComponent as ProjectileBehaviorComponent

var speed: int
var damage: int
var velocity: Vector2
var pierce: int
var vfx_finished := false
var explosion_type := preload("res://entities/projectiles/snowbomb_explosion.tscn")
var explosive_scale := 2.0
var exploded := false


# initialize properties
func start(_position: Vector2, _rotation: float, _speed: int, _damage: int, _scale: float, _pierce: int, _aim_component_position: Vector2) -> void:
	projectile_behavior_component.initialize_projectile_behavior(_position, _rotation, _speed, _damage, _scale, _pierce, _aim_component_position)


# every physics frame, update velocity
func _physics_process(delta: float) -> void:
	projectile_behavior_component.update_projectile_velocity(delta)


# collide with target
func _hit() -> void:
	projectile_behavior_component.explosive_hit()


# when animations are finished, attempt to despawn
func _on_hit_vfx_animation_finished() -> void:
	vfx_finished = true
	projectile_behavior_component.projectile_finished_explosive(vfx_finished)


# if snowbomb collides with target
func _on_body_entered(body: Node2D) -> void:
	if not exploded:
		projectile_behavior_component.body_entered_explosive(body, explosion_type)
		exploded = true


# despawn if moving too far without hitting something
func _on_lifespan_timer_timeout() -> void:
	projectile_behavior_component.despawn()
