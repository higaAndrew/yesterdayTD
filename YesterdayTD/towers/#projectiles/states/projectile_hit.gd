extends State

var hit_vfx: AnimatedSprite2D
var pierce: PierceComponent

var animation_done := false
var sound_done := false

## get parent's components
func init() -> void:
	hit_vfx = parent.hit_vfx
	GlobalScripts.connect_signal(hit_vfx, "animation_finished", self, "_on_hit_vfx_animation_finished")
	
	pierce = parent.pierce
	GlobalScripts.connect_signal(pierce, "pierce_zero", self, "_on_pierce_zero")


## every loop, perform hit functions
func loop() -> void:
	parent.damage.play_hit_sound()
	parent.pierce.reduce_pierce()


## when pierce runs out, destroy self
func _on_pierce_zero() -> void:
	GlobalScripts.play_animation(parent, hit_vfx, "hit")


## when hit vfx animation is finished
func _on_hit_vfx_animation_finished() -> void:
	if hit_vfx.animation == "hit":
		animation_done = true
