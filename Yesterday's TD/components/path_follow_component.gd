class_name PathFollowComponent
extends Node2D

@export var health_component: HealthComponent
@export var speed_component: SpeedComponent

var stopped := false

@onready var path := $"../../" as PathFollow2D


func _physics_process(delta: float) -> void:
	# follow along the map's path
	path.set_progress(path.get_progress() + speed_component.speed * delta)
	# if node has reached the end of the path and nothing has happened, throw an error
	if path.get_progress_ratio() == 1:
		push_error("Object has reached end of path with no reaction. Are you missing the objective?")
