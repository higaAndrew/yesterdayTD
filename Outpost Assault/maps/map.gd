extends Node2D

@onready var tilemap := $TileMap as TileMap
@onready var camera := $Camera2D as Camera2D
@onready var objective := $Objective as Objective
@onready var spawner := $Spawner as Spawner


func _ready():
	# initialize camera
	var map_limits := tilemap.get_used_rect()
	var tile_size := tilemap.tile_set.tile_size
	camera.limit_left = map_limits.position.x * tile_size.x
	camera.limit_right = map_limits.end.x * tile_size.x
	camera.limit_top = map_limits.position.y * tile_size.y
	camera.limit_bottom = map_limits.end.y * tile_size.y
	# initialize money and connect signals
	var hud = camera.hud as HUD
	hud.initialize(objective.health)
	objective.health_changed.connect(hud._on_objective_health_changed)
	spawner.countdown_started.connect(hud._on_spawner_countdown_started)
	spawner.wave_started.connect(hud._on_spawner_wave_started)
