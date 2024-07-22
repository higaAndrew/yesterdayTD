class_name Hitbox
extends CollisionShape2D
## TODO desc

signal collided

@export var range_indicator_color: Color = Color(0.0, 0.0, 1.0, 0.1)
var current_collision: Area2D

func _ready() -> void:
	self.set_visible(false)


func _draw() -> void:
	draw_circle(Vector2.ZERO, self.shape.radius, range_indicator_color)


## method for declaring a collsion, typically activated by outside scenes
## this method should only be read by the parent's state machine
func collide() -> void:
	collided.emit()


## disable hitbox
## the debugger gets pissy when you use set_disabled, so this is a passable workaround
func disable_hitbox() -> void:
	self.global_position = Vector2(-128, -128)
	self.set_deferred("disabled", true)
