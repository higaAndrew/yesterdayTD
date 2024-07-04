extends State


var hitbox: Hitbox
var animations: AnimatedSprite2D
var explosion_sound: AudioStreamPlayer
var lifespan_timer: Timer
var damage: DamageComponent
var pierce: PierceComponent

var animation_done: bool = false
var sound_done: bool = false


## get parent's components
func enter() -> void:
	damage = parent.damage
	
	hitbox = parent.hitbox
	GlobalScripts.connect_signal(hitbox, "collided", self, "_on_hitbox_collided")
	
	animations = parent.animations
	GlobalScripts.connect_signal(animations, "animation_finished", self, "_on_animation_finished")
	
	explosion_sound = parent.explosion_sound
	GlobalScripts.connect_signal(explosion_sound, "finished", self, "_on_explosion_sound_finished")
	
	lifespan_timer = parent.lifespan_timer
	GlobalScripts.connect_signal(lifespan_timer, "timeout", self, "_on_lifespan_timer_timeout")
	
	pierce = parent.pierce
	GlobalScripts.connect_signal(pierce, "pierce_depleted", self, "_on_pierce_depleted")
	
	damage.play_hit_sound()
	lifespan_timer.start(parent.stats.base_lifespan)


## when colliding with an enemy
func _on_hitbox_collided() -> void:
	pierce.reduce_pierce()


## when the explosion animation is finished
func _on_animation_finished() -> void:
	animation_done = true
	check_delete()


## when explosion sound is finished
func _on_explosion_sound_finished() -> void:
	sound_done = true
	check_delete()


## when the lifespan timer finishes, disable the hitbox
func _on_lifespan_timer_timeout() -> void:
	if not hitbox.is_disabled():
		hitbox.disable_hitbox()


## when pierce runs out, destroy self
func _on_pierce_depleted() -> void:
	hitbox.disable_hitbox()


## if the explosion animation and sound are finished, delete the explosion
## alternatively, if the animation is finished and there's no sound for whatever reason
func check_delete() -> void:
	if animation_done and sound_done:
		parent.queue_free()
	elif animation_done and not is_instance_valid(explosion_sound.stream):
		parent.queue_free()
