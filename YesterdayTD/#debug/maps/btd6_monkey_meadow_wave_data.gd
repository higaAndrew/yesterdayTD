extends WaveData


func _ready() -> void:
	debug_waves = [
		#[# 1
			#["piston", 10, 0.5, 1],
			#["rivet", 10, 0.5, 1],
			#["cog", 10, 0.5, 1],
			#["bolt", 10, 0.1, 1],
		#],
		#[# 2
			#["hammer", 10, 2, 1],
			#["anvil", 10, 3, 1],
		#],
		[# 3
			["flying_piston", 10, 0.5, 1],
			["rotor", 10, 3, 1],
		],
		[# everything
			["piston", 10, 0.5, 0],
			["rivet", 10, 0.5, 0],
			["cog", 10, 0.5, 0],
			["bolt", 10, 0.1, 0],
			["hammer", 10, 2, 0],
			["anvil", 10, 3, 0],
			["rotor", 10, 3, 0],
		]
	]
	pass
