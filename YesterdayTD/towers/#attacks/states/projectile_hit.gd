extends State


var hitbox: Hitbox
var animations: AnimatedSprite2D
var hit_vfx: AnimatedSprite2D
var pierce: PierceComponent
var sound: SoundComponent


## get parent's components
func init() -> void:
	hitbox = parent.hitbox
	animations = parent.animations
	sound = parent.sound
	
	hit_vfx = parent.hit_vfx
	GlobalScripts.connect_signal(hit_vfx, "animation_finished", self, "_on_hit_vfx_animation_finished")
	
	pierce = parent.pierce
	GlobalScripts.connect_signal(pierce, "pierce_depleted", self, "_on_pierce_depleted")
	


## every loop, perform hit methods
func loop() -> void:
	sound.play_hit_sound()
	pierce.reduce_pierce()
	
	if pierce.current_pierce >= 1:
		transitioned.emit(self, "ProjectileMove")


## when pierce runs out, destroy self
func _on_pierce_depleted() -> void:
	animations.hide()
	hit_vfx.show()
	GlobalScripts.play_animation(parent, hit_vfx, "hit")
	hitbox.remove_hitbox()


## when hit vfx animation is finished
func _on_hit_vfx_animation_finished() -> void:
	if hit_vfx.animation == "hit":
		parent.queue_free()
