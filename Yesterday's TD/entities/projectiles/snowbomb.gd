class_name Snowbomb
extends Area2D

@onready var projectile_behavior_component := $ProjectileBehaviorComponent as ProjectileBehaviorComponent

var speed: int
var damage: int
var velocity: Vector2
var projectile_penetration: int
var vfx_finished := false
var sound_finished := false
var explosive := "snowbomb_explosion"
var explosive_scale := 2.0


func start(_position: Vector2, _rotation: float, _speed: int, _damage: int, _scale: float, _projectile_penetration: int, _aim_component_position: Vector2) -> void:
	projectile_behavior_component.initialize_projectile_behavior(_position, _rotation, _speed, _damage, _scale, _projectile_penetration, _aim_component_position)


func _physics_process(delta: float) -> void:
	projectile_behavior_component.update_projectile_velocity(delta)


func _hit() -> void:
	projectile_behavior_component.projectile_hit()


func _on_hit_vfx_animation_finished() -> void:
	vfx_finished = true
	projectile_behavior_component.projectile_finished_explosive(vfx_finished)


func _on_body_entered(body: Node2D) -> void:
	projectile_behavior_component.body_entered_explosive(body, explosive)


func _on_lifespan_timer_timeout() -> void:
	projectile_behavior_component.despawn()
