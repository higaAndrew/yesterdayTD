class_name PathFollowComponent
extends Node2D

@export var velocity_component: VelocityComponent

@onready var path := $"../../" as PathFollow2D

var stopped := false


func _physics_process(delta: float) -> void:
	# follow along the map's path
	path.set_progress(path.get_progress() + velocity_component.speed * delta)
	# if node has reached the end of the path and nothing has happened, throw an error
	if path.get_progress_ratio() == 1:
		push_error("Object has reached end of path with no reaction. Are you missing the objective?")
