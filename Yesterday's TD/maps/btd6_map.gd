extends Node2D

@export var monet := 500
@export var waves := []
@export var wave_delay := 10

@onready var gamerules := $Gamerules as Gamerules
@onready var spawner := $Spawner as Spawner


# set spawn waves for map
# spawn group format:
# {"enemy_type": "", "enemy_count": , "spawn_delay": , "group_delay": },
var classic_waves := [
	[	# wave 1
		{"enemy_type": "piston", "enemy_count": 5, "spawn_delay": 0.5, "group_delay": 2.0},
		{"enemy_type": "rivet", "enemy_count": 10, "spawn_delay": 0.25, "group_delay": 5.0},
		{"enemy_type": "cog", "enemy_count": 7, "spawn_delay": 0.1, "group_delay": 0.1},
	],
	[	# wave 2
		{"enemy_type": "piston", "enemy_count": 30, "spawn_delay": 0.01, "group_delay": 0.001},
		{"enemy_type": "piston", "enemy_count": 30, "spawn_delay": 0.05, "group_delay": 0.0},
	]
]


# set gamemode
func _ready() -> void:
	if gamerules.gamemode == "classic":
		waves = classic_waves
