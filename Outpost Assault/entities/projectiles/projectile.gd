class_name Projectile
extends Area2D

@onready var anim_sprite := $AnimatedSprite2D as AnimatedSprite2D
@onready var collision_shape := $CollisionShape2D as CollisionShape2D
@onready var hit_vfx := $HitVfx as AnimatedSprite2D
@onready var hit_sound := $HitSound as AudioStreamPlayer2D

var speed: int
var damage: int
var velocity: Vector2
var target: Node2D # only used by homing missiles


func start(_position: Vector2, _rotation: float, _speed: int, _damage: int, _target: Node2D) -> void:
	global_position = _position
	rotation = _rotation
	speed = _speed
	damage = _damage
	target = _target
	velocity = Vector2.RIGHT.rotated(_rotation) * speed


func _physics_process(delta: float) -> void:
	global_position += velocity * delta


func _explode() -> void:
	set_physics_process(false)
	collision_shape.set_deferred("disabled", true)
	anim_sprite.hide()
	hit_vfx.show()
	hit_vfx.play("hit")
	hit_sound.play()


func _on_hit_vfx_animation_finished() -> void:
	queue_free()


func _on_body_entered(body: Node2D) -> void:
	if body is Enemy or body is Tower:
		body.health -= damage
		_explode()


func _on_lifetime_timer_timeout() -> void:
	queue_free()


func _on_area_entered(area: Area2D) -> void:
	if area is Objective:
		area.health -= damage
		_explode()
