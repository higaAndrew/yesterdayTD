extends State

var snowball_scene: PackedScene
var animations: AnimatedSprite2D
var snowball_cooldown_timer: Timer
var targets: TargetsComponent
var target_priority:String
var target: Area2D

var target_rotation: float
var snowball: Area2D
var projectiles: CanvasLayer


## get parent's components
func init() -> void:
	animations = parent.animations
	GlobalScripts.connect_signal(animations, "animation_finished", self, "_on_animation_finished")
	
	snowball_cooldown_timer = parent.snowball_cooldown_timer
	GlobalScripts.connect_signal(snowball_cooldown_timer, "timeout", self, "_on_cooldown_timer_timeout")
	
	snowball_scene = parent.attack0_scene
	targets = parent.targets
	target_priority = parent.stats.target_priority


## every loop,
## get the target at the front of the target list (according to target priority), and rotate towards it
## create a snowball and init its velocity
## reset the timer's count according to the stats, and start it
func loop() -> void:
	targets.get_target(target_priority)
	target = targets.target
	target_rotation = parent.global_position.angle_to_point(target.global_position)
	parent.rotation = target_rotation
	
	GlobalScripts.play_animation(parent, animations, "throw")
	snowball = snowball_scene.instantiate()
	parent.snowball_attack.init_projectile(snowball)
	snowball_cooldown_timer.set_wait_time(parent.snowball_attack.current_attack_cooldown)
	snowball_cooldown_timer.start()


## when the shoot animation stops playing, switch back to idle
func _on_animation_finished() -> void:
	if animations.animation == "throw":
		GlobalScripts.play_animation(parent, animations, "idle")


## when timer is up, return to idle state to prepare for another attack
func _on_cooldown_timer_timeout() -> void:
	transitioned.emit(self, "AttackIdleSnowball")
