extends State

var snowball_scene: PackedScene
var snowball_cooldown_timer: Timer

var snowball: Area2D
var projectiles: CanvasLayer


## get parent's components
func init() -> void:
	snowball_scene = parent.snowball_scene
	snowball_cooldown_timer = parent.snowball_cooldown_timer
	GlobalScripts.connect_signal(snowball_cooldown_timer, "timeout", self, "_on_cooldown_timer_timeout")


## every loop, create a snowball
## init its velocity
## reset the timer's count according to the stats
## start said timer
func loop() -> void:
	snowball = snowball_scene.instantiate()
	parent.snowball_attack.init_projectile(snowball)
	snowball_cooldown_timer.set_wait_time(parent.snowball_attack.current_attack_cooldown)
	snowball_cooldown_timer.start()


## when timer is up, return to idle state to prepare for another attack
func _on_cooldown_timer_timeout() -> void:
	transition.emit(self, "AttackIdleSnowball")
