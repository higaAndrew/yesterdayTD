extends Projectile

@export var rotation_speed := 600.0


func _physics_process(delta: float) -> void:
	if target and is_instance_valid(target):
		var shooter = target.get_shooter()
		if not shooter:
			_not_dying(delta)
		elif shooter.gun.animation != "die":
			_not_dying(delta)
	global_position += velocity * delta


func _not_dying(delta: float) -> void:
	var desired_velocity := global_position.direction_to(target.global_position) * speed
	var velocity_change := velocity.direction_to(desired_velocity) * rotation_speed * delta
	velocity = (velocity + velocity_change).limit_length(speed)
	rotation = velocity.angle()
