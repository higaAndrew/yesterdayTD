extends State


## TODO between rounds
## prepare for the first wave
func enter() -> void:
	if parent.current_wave == 0:
		transition.emit(self, "SpawnWave")
	else:
		print("all done here!")
