extends State


var spawning: SpawningComponent


## setup timer and wave count
func init() -> void:
	spawning = parent.spawning


## every loop, start the wave timer
func loop() -> void:
	if spawning.current_wave < spawning.wave_count:
		transitioned.emit(self, "SpawnGroup")
	else:
		transitioned.emit(self, "SpawnerIdle")
