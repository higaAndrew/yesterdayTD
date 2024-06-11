extends State

var lifespan_timer: Timer
var velocity: VelocityComponent

var projectiles: CanvasLayer


## get parent's components
func init() -> void:
	lifespan_timer = parent.lifespan_timer
	GlobalScripts.connect_signal(lifespan_timer, "timeout", self, "_on_lifespan_timer_timeout")
	velocity = parent.velocity
	
	lifespan_timer.start(parent.stats.base_lifespan)


## every physics frame, move in specified direction
func physics_process(delta: float) -> void:
	velocity.update_velocity(delta)


## if lifespan timer times out before hitting anything, despawn
func _on_lifespan_timer_timeout() -> void:
	if not current_state():
		return
	parent.queue_free()
