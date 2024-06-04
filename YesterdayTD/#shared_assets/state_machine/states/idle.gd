class_name Idle
extends State

var health: HealthComponent


## get reference to parent's components
func enter() -> void:
	health = parent.health

	GlobalScripts.connect_signal(parent, "area_entered", self, "_on_area_entered")
	GlobalScripts.connect_signal(health, "health_zero", self, "_on_health_zero")


## check health
func physics_process(delta: float) -> void:
	pass

func _on_area_entered(area: Area2D) -> void:
	print("something just touched me!!!")
	if area.is_in_group("enemies"):
		print("and it's an enemy!")
	if area.name == "DespawnPoint":
		print("despawn it!!!")

func _on_health_zero() -> void:
	print("health is zero!")
