extends State

var animations: AnimatedSprite2D
var debug_projectile_cooldown_timer: Timer
var debug_projectile_scene: PackedScene

var debug_projectile: Area2D
var projectiles: CanvasLayer


## get parent's components
func init() -> void:
	animations = parent.animations
	GlobalScripts.connect_signal(animations, "animation_finished", self, "_on_animation_finished")
	
	debug_projectile_cooldown_timer = parent.debug_projectile_cooldown_timer
	GlobalScripts.connect_signal(debug_projectile_cooldown_timer, "timeout", self, "_on_cooldown_timer_timeout")
	
	debug_projectile_scene = parent.attack0_scene


## every loop, create a debug projectile
## init its velocity
## reset the timer's count according to the stats
## start said timer
func loop() -> void:
	GlobalScripts.play_animation(parent, animations, "throw")
	debug_projectile = debug_projectile_scene.instantiate()
	parent.debug_projectile_attack.init_projectile(debug_projectile)
	debug_projectile_cooldown_timer.set_wait_time(parent.debug_projectile_attack.current_attack_cooldown)
	debug_projectile_cooldown_timer.start()


## when the shoot animation stops playing, switch back to idle
func _on_animation_finished() -> void:
	if animations.animation == "throw":
		GlobalScripts.play_animation(parent, animations, "idle")


## when timer is up, return to idle state to prepare for another attack
func _on_cooldown_timer_timeout() -> void:
	transition.emit(self, "AttackIdleDebugProj")
