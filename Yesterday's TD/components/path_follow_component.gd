extends Node2D

@export var speed_component: SpeedComponent
@export var health_component: HealthComponent

@onready var path_follow_2d := $"../../" as PathFollow2D

var finished := false


func _physics_process(delta: float) -> void:
	# follow along the map's path
	path_follow_2d.set_progress(path_follow_2d.get_progress() + speed_component.speed * delta)

	# delete when reaching exit
	if path_follow_2d.get_progress_ratio() == 1:

		# if parent has health, set it to 0 and delete it
		if health_component and not finished:
			health_component.die()

		# only execute once
		finished = true
