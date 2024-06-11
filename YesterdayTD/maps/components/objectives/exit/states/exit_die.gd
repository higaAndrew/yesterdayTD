extends State

var health: HealthComponent

## objective is destroyed
func enter() -> void:
	health = parent.health
	
	health.disable_hitbox()
	health.play_death_sound()
	print("The objective is dead!")
