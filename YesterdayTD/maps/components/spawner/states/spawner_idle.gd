extends State


var spawning: SpawningComponent


## TODO between rounds
## prepare for the first wave
func init() -> void:
	spawning = parent.spawning


## handle spawning waves
func loop() -> void:
	if spawning.current_wave == 0:
		transitioned.emit(self, "SpawnWave")
	else:
		print("All the waves are done!")
