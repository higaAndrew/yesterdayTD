extends State

var snowball_scene: PackedScene
var snowball_cooldown_timer: Timer

var snowball: Area2D
var projectiles: CanvasLayer


func init() -> void:
	snowball_scene = parent.snowball_scene
	snowball_cooldown_timer = parent.snowball_cooldown_timer
	GlobalScripts.connect_signal(snowball_cooldown_timer, "timeout", self, "_on_cooldown_timer_timeout")


func loop() -> void:
	snowball = snowball_scene.instantiate()
	parent.snowball_attack.init_projectile(snowball)
	snowball_cooldown_timer.set_wait_time(parent.snowball_attack.current_attack_cooldown)
	snowball_cooldown_timer.start()


func _on_cooldown_timer_timeout() -> void:
	transitioned.emit(self, "AttackIdleSnowball")
