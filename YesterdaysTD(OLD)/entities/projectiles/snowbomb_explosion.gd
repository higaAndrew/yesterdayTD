class_name SnowbombExplosion
extends Area2D

@onready var explosion_behavior_component := $ExplosionBehaviorComponent as ExplosionBehaviorComponent
@onready var explosion_sound := $ExplosionSound as AudioStreamPlayer

var damage: int
var pierce: int
var animation_finished := false
var sound_finished := false


# send properties to explosion behavior component
func start(_position: Vector2, _rotation: float, _damage: int, _scale: float, _pierce: int) -> void:
	explosion_behavior_component.initialize_explosion_behavior(_position, _rotation, _damage, _scale, _pierce)
	explosion_sound.play()


# when animation finishes, attempt to despawn
func _on_animated_sprite_2d_animation_finished() -> void:
	animation_finished = true
	explosion_behavior_component.explosion_finished(animation_finished, sound_finished)


# when sound finishes, attempt to despawn
func _on_explosion_sound_finished() -> void:
	sound_finished = true
	explosion_behavior_component.explosion_finished(animation_finished, sound_finished)


# if explosion collides with entity
func _on_body_entered(body: Node2D) -> void:
	explosion_behavior_component.body_entered(body)


# end the damage window
func _on_damage_window_timeout() -> void:
	explosion_behavior_component.end_damage_window()