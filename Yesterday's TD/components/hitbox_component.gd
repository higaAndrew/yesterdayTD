class_name HitboxComponent
extends Area2D

signal enemy_entered(enemy: Node2D)
signal enemy_exited(enemy: Node2D)
signal tower_entered(tower: Node2D)
signal tower_exited(tower: Node2D)

# Hitbox Component requires a CollisionShape2D to function
@onready var hitbox: CollisionShape2D = get_child(0)


# enable hitbox
func enable_collision() -> void:
	hitbox.set_deferred("disabled", false)


# disable hitbox
func disable_collision() -> void:
	hitbox.set_deferred("disabled", true)


# if entity collides with hitbox
func _on_body_entered(body: Node2D) -> void:
	# determine what collided with self
	if body.is_in_group("enemy"):
		enemy_entered.emit(body)
	elif body.is_in_group("tower"):
		tower_entered.emit(body)


# if entity stops colliding with hitbox
func _on_body_exited(body: Node2D) -> void:
	# determine what stopped colliding with self
	if body.is_in_group("enemy"):
		enemy_exited.emit(body)
	elif body.is_in_group("tower"):
		tower_exited.emit(body)
