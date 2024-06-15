class_name VelocityComponent
extends Node

@export var speed: SpeedComponent

var parent: Area2D
var velocity: Vector2
var direction: Vector2


## get speed and set velocity values
func init(_parent: Area2D) -> void:
	parent = _parent


## set the parent's global position
func set_global_position(_global_position: Vector2) -> void:
	parent.global_position = _global_position


## set the parent's rotation
func set_rotation(_rotation: float) -> void:
	parent.rotation = _rotation


## set the parent's direction based on destination
func set_direction(_destination: Vector2) -> void:
	direction = (_destination - parent.global_position).normalized()


## set the parent's velocity based on 
func set_velocity() -> void:
	# normal velocity calculation
	#velocity = direction * speed.current_speed
	# go straight forwards
	velocity = Vector2.RIGHT.rotated(parent.rotation) * speed.current_speed


## update the parent's velocity
func update_velocity(delta: float) -> void:
	parent.global_position += velocity * delta
