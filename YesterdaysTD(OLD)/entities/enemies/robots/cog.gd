class_name Cog
extends CharacterBody2D

@onready var animated_sprite := $AnimatedSprite2D as AnimatedSprite2D
@onready var collision_shape := $CollisionShape2D as CollisionShape2D
@onready var damage_component := $DamageComponent as DamageComponent
@onready var health_component := $HealthComponent as HealthComponent
@onready var velocity_component := $VelocityComponent as VelocityComponent


# initialize properties
func _ready() -> void:
	health_component.initialize()


# die
func _on_health_component_dead() -> void:
	collision_shape.set_deferred("disabled", true)
	velocity_component.set_speed(0)
	animated_sprite.play("die")


# delete when death animation is finished
func _on_animated_sprite_2d_animation_finished() -> void:
	if animated_sprite.animation == "die":
		get_parent().queue_free()
