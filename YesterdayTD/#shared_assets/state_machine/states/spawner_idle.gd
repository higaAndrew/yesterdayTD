class_name SpawnerIdle
extends State


## TODO between rounds
## prepare for the first wave
func enter() -> void:
	if parent.current_wave == 0:
		transitioned.emit(self, "spawnwave")
	else:
		print("all done here!")
