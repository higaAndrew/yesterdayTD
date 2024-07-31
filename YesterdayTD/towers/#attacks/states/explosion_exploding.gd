extends State


var hitbox: Hitbox
var animations: AnimatedSprite2D
var lifespan_timer: Timer
var damage: DamageComponent
var pierce: PierceComponent
var sound: SoundComponent


## get parent's components
func enter() -> void:
	damage = parent.damage
	sound = parent.sound
	
	hitbox = parent.hitbox
	GlobalScripts.connect_signal(hitbox, "collided", self, "_on_hitbox_collided")
	
	animations = parent.animations
	GlobalScripts.connect_signal(animations, "animation_finished", self, "_on_animation_finished")
	
	lifespan_timer = parent.lifespan_timer
	GlobalScripts.connect_signal(lifespan_timer, "timeout", self, "_on_lifespan_timer_timeout")
	
	pierce = parent.pierce
	GlobalScripts.connect_signal(pierce, "pierce_depleted", self, "_on_pierce_depleted")
	
	sound.play_explosion_sound()
	lifespan_timer.start(parent.stats.base_lifespan)


## when colliding with an enemy
func _on_hitbox_collided() -> void:
	pierce.reduce_pierce()


## when the explosion animation is finished
func _on_animation_finished() -> void:
	delete()


## when the lifespan timer finishes, disable the hitbox
func _on_lifespan_timer_timeout() -> void:
	if not hitbox.is_disabled():
		hitbox.disable_hitbox()


## when pierce runs out, destroy self
func _on_pierce_depleted() -> void:
	hitbox.remove_hitbox()


## if the explosion animation is finished, delete the explosion
func delete() -> void:
	parent.queue_free()
