class_name Hitbox
extends CollisionShape2D

signal collided


## method for declaring a collsion, typically activated by outside scenes
## this method should only be read by the parent's state machine
func collide() -> void:
	collided.emit()


## disable hitbox
## the debugger gets pissy when you use set_disabled, so this is a passable workaround
func disable_hitbox() -> void:
	self.global_position = Vector2(-64, -64)
	self.set_deferred("disabled", true)