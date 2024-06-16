extends State

var debug_projectile_scene: PackedScene
var animations: AnimatedSprite2D
var debug_projectile_cooldown_timer: Timer
var targets: TargetsComponent
var target_priority:String
var target: Area2D

var target_rotation: float
var debug_projectile: Area2D
var projectiles: CanvasLayer


## get parent's components
func init() -> void:
	animations = parent.animations
	GlobalScripts.connect_signal(animations, "animation_finished", self, "_on_animation_finished")
	
	debug_projectile_cooldown_timer = parent.debug_projectile_cooldown_timer
	GlobalScripts.connect_signal(debug_projectile_cooldown_timer, "timeout", self, "_on_cooldown_timer_timeout")
	
	debug_projectile_scene = parent.attack0_scene
	targets = parent.targets
	target_priority = parent.stats.target_priority


## every loop,
## get the target at the front of the target list (according to target priority), and rotate towards it
## create a debug projectile and init its velocity
## reset the timer's count according to the stats, and start it
func loop() -> void:
	targets.get_target(target_priority)
	target = targets.target
	target_rotation = parent.global_position.angle_to_point(target.global_position)
	parent.rotation = target_rotation
	
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
	transitioned.emit(self, "AttackIdleDebugProj")
