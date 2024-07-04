extends WaveData


func _ready() -> void:
	debug_waves = [
		[	# wave 1
			["piston", 10, 0.5, 1],
			["rivet", 10, 0.5, 1],
			["cog", 10, 0.5, 5],
			["bolt", 10, 0.1, 1],
			["hammer", 10, 2, 1],
			["anvil", 10, 3, 5],
		],
		[
			["piston", 30, 0.1, 3],
		]
	]
	pass
