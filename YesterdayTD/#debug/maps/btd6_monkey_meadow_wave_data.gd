extends WaveData


func _ready() -> void:
	debug_waves = [
		[# 1
			["piston", 10, 0.5, 1],
		],
		[# 2
			["rivet", 10, 0.5, 1],
		],
		[# 3
			["cog", 10, 0.5, 5],
		],
		[# 4
			["bolt", 10, 0.1, 1],
		],
		[# 5
			["hammer", 10, 2, 1],
		],
		[# 6
			["anvil", 10, 3, 5],
		],
		[# 7
			["piston", 10, 0.5, 0],
			["rivet", 10, 0.5, 0],
			["cog", 10, 0.5, 0],
			["bolt", 10, 0.1, 0],
			["hammer", 10, 2, 0],
			["anvil", 10, 3, 0],
		]
	]
	pass
