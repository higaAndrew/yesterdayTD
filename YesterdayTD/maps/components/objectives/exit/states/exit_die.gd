extends State


var hitbox: Hitbox
var sound: SoundComponent


## objective is destroyed
func enter() -> void:
	hitbox = parent.hitbox
	sound = parent.sound
	
	hitbox.remove_hitbox()
	sound.play_death_sound()
	print("The objective is dead!")
