extends State

var hitbox: Hitbox
var lifespan_timer: Timer
var velocity: VelocityComponent


## get parent's components
func init() -> void:
	hitbox = parent.hitbox
	GlobalScripts.connect_signal(hitbox, "collided", self, "_on_hitbox_collided")
	
	lifespan_timer = parent.lifespan_timer
	GlobalScripts.connect_signal(lifespan_timer, "timeout", self, "_on_lifespan_timer_timeout")
	
	GlobalScripts.connect_signal(parent, "area_entered", self, "_on_area_entered")
	
	velocity = parent.velocity
	lifespan_timer.start(parent.stats.base_lifespan)


## every physics frame, move in specified direction
func physics_process(delta: float) -> void:
	velocity.update_velocity(delta)


## when colliding with an enemy
func _on_hitbox_collided() -> void:
	if not current_state():
		return
	
	transition.emit(self, "ProjectileHit")


## if lifespan timer times out before hitting anything, despawn
func _on_lifespan_timer_timeout() -> void:
	if not current_state():
		return
	parent.queue_free()
