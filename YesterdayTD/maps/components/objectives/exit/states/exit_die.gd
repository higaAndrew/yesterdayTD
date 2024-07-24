extends State


var hitbox: Hitbox
var health: HealthComponent


## objective is destroyed
func enter() -> void:
	hitbox = parent.hitbox
	health = parent.health
	
	hitbox.remove_hitbox()
	health.play_death_sound()
	print("The objective is dead!")
