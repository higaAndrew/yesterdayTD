extends State


var explosion_scene: PackedScene

var hitbox: Hitbox
var animations: AnimatedSprite2D
var hit_vfx: AnimatedSprite2D
var hit_sound: AudioStreamPlayer
var pierce_cooldown_timer: Timer
var attack: AttackComponent
var damage: DamageComponent
var pierce: PierceComponent

var explosion: Area2D
var layer: CanvasLayer
var animation_done: bool = false
var sound_done: bool = false


## get parent's components
func init() -> void:
	explosion_scene = parent.get("attack%s_scene" % attack_number)
	hitbox = parent.hitbox
	animations = parent.animations
	pierce_cooldown_timer = parent.pierce_cooldown_timer
	attack = parent.attack
	damage = parent.damage
	
	hit_vfx = parent.hit_vfx
	GlobalScripts.connect_signal(hit_vfx, "animation_finished", self, "_on_hit_vfx_animation_finished")
	
	hit_sound = parent.hit_sound
	GlobalScripts.connect_signal(hit_sound, "finished", self, "_on_hit_sound_finished")
	
	pierce = parent.pierce
	GlobalScripts.connect_signal(pierce, "pierce_depleted", self, "_on_pierce_depleted")


## every loop, perform hit methods
## init explosion must be call_deferred for some reason
func loop() -> void:
	damage.play_hit_sound()
	pierce.reduce_pierce()
	
	explosion = explosion_scene.instantiate()
	attack.call_deferred("init_explosion", explosion)
	
	if pierce.current_pierce >= 1:
		pierce.pierce_active = false
		pierce_cooldown_timer.start(pierce.current_pierce_cooldown)
		transitioned.emit(self, "BombMove")


## when hit vfx animation is finished
func _on_hit_vfx_animation_finished() -> void:
	if not current_state():
		return
	
	if hit_vfx.animation == "hit":
		animation_done = true
		check_delete()


## when hit sound is finished
func _on_hit_sound_finished() -> void:
	if not current_state():
		return
	
	if pierce.pierce_expended:
		sound_done = true
		check_delete()


## when pierce runs out, destroy self
func _on_pierce_depleted() -> void:
	#explosion = explosion_scene.instantiate()
	#
	#attack.call_deferred("init_explosion", explosion)
	
	animations.hide()
	hit_vfx.show()
	GlobalScripts.play_animation(parent, hit_vfx, "hit")
	hitbox.remove_hitbox()


## if the hit animation and the hit sound are finished, delete the snowball
## alternatively, if the hit animation is finished and there's no hit sound for whatever reason
func check_delete() -> void:
	if animation_done and sound_done:
		parent.queue_free()
	elif animation_done and not is_instance_valid(hit_sound.stream):
		parent.queue_free()
