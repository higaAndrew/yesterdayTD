class_name Hitbox
extends CollisionShape2D


signal collided

@export var range_indicator_color: Color = Color(0.0, 0.0, 1.0, 0.15)

var current_collision: Area2D
var hitbox_visible: bool = false
var range_color: Color


## draw a shape representing the collision shap
## only appears if hitbox is visible
func _draw() -> void:
	if hitbox_visible:
		if self.shape is CircleShape2D or CapsuleShape2D:
			draw_circle(Vector2.ZERO, self.shape.radius, range_color)
		elif self.shape is RectangleShape2D:
			printerr("why is the collisionshape a rectangle, i don't wanna deal with that")
		else:
			printerr("you used the wrong shape >:[")


## method for declaring a collsion, typically activated by outside scenes
## this method should only be read by the parent's state machine
## HACK add the collider?
func collide() -> void:
	collided.emit()


## remove hitbox
## the debugger gets pissy when you use set_disabled, so this is a passable workaround
func remove_hitbox() -> void:
	self.global_position = Vector2(-128, -128)
	self.set_deferred("disabled", true)


## disable hitbox
func disable_hitbox() -> void:
	self.set_deferred("disabled", true)


## enable hitbox
func enable_hitbox() -> void:
	self.set_deferred("disabled", false)


## show the hitbox shape
func reveal_hitbox() -> void:
	hitbox_visible = true
	self.queue_redraw()


## hide the hitbox shape
func hide_hitbox() -> void:
	hitbox_visible = false
	self.queue_redraw()


## toggle the hitbox shape's visibility
func toggle_hitbox_visibility() -> void:
	hitbox_visible = not hitbox_visible
	self.queue_redraw()


## change the hitbox's color to a new given color
## typically used for invalid placement color
func change_hitbox_color(new_color: Color) -> void:
	if range_color != new_color:
		range_color = new_color
		self.queue_redraw()


## restore the hitbox's color to the default color
func restore_hitbox_color() -> void:
	if range_color != range_indicator_color:
		range_color = range_indicator_color
		self.queue_redraw()
