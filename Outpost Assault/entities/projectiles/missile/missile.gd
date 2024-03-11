extends Projectile

@export var rotation_speed := 600.0


func _physics_process(delta: float) -> void:
	if target and is_instance_valid(target) and target.shooter.gun.animation != "die":
		var desired_velocity := global_position.direction_to(target.global_position) * speed
		var velocity_change := velocity.direction_to(desired_velocity) * rotation_speed * delta
		velocity = (velocity + velocity_change).limit_length(speed)
		rotation = velocity.angle()
	global_position += velocity * delta
