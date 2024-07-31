extends State


var target_priority: String
var projectile_scene: PackedScene

var animations: AnimatedSprite2D
var cooldown_timer: Timer
var attack: AttackComponent
var cooldown: CooldownComponent
var targets: TargetsComponent

var target: Area2D
var target_rotation: float
var projectile: Area2D


## get parent's components
func init() -> void:
	target_priority = parent.stats.target_priority
	projectile_scene = parent.get("attack%s_scene" % attack_number)
	attack = parent.attack
	cooldown = parent.cooldown
	targets = parent.targets
	
	animations = parent.animations
	GlobalScripts.connect_signal(animations, "animation_finished", self, "_on_animation_finished")
	
	cooldown_timer = parent.get("attack%s_cooldown_timer" % attack_number)
	GlobalScripts.connect_signal(cooldown_timer, "timeout", self, "_on_cooldown_timer_timeout")


## every loop,
## get the target at the front of the target list (according to target priority), and rotate towards it
## create a projectile and init its velocity
## reset the timer's count according to the stats, and start it
func loop() -> void:
	targets.get_target(target_priority)
	target = targets.target
	target_rotation = parent.global_position.angle_to_point(target.global_position)
	parent.rotation = target_rotation
	GlobalScripts.play_animation(parent, animations, "throw")
	
	projectile = projectile_scene.instantiate()
	
	attack.init_projectile(attack_number, projectile)
	cooldown_timer.start(cooldown.get_attack_cooldown(attack_number))


## when the shoot animation stops playing, switch back to idle
func _on_animation_finished() -> void:
	if animations.animation == "throw":
		GlobalScripts.play_animation(parent, animations, "idle")


## when timer is up, return to idle state to prepare for another attack
func _on_cooldown_timer_timeout() -> void:
	transitioned.emit(self, "AttackProjectileIdle")
