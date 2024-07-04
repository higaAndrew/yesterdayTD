class_name SpawningComponent
extends Node


## preload every enemy
## HACK would autoload be a good idea?
@export var enemies: Dictionary = {
	"piston": preload("res://enemies/ground_enemies/piston/piston.tscn"),
	"rivet": preload("res://enemies/ground_enemies/rivet/rivet.tscn"),
	"cog": preload("res://enemies/ground_enemies/cog/cog.tscn"),
	"bolt": preload("res://enemies/ground_enemies/bolt/bolt.tscn"),
	"hammer": preload("res://enemies/ground_vehicles/hammer/hammer.tscn"),
	"anvil": preload("res://enemies/ground_vehicles/anvil/anvil.tscn"),
}

## variables from parent
var parent: Node2D
var wave_data: WaveData
var wave_set: String
var wave_delay: float

## individual paths for rendering layers
var canvas: Canvas
var path: Path2D
var ground_enemies: Path2D
var ground_vehicles: Path2D
var ground_bosses: Path2D
var air_enemies: Path2D
var air_vehicles: Path2D
var air_bosses: Path2D

## wave set properties
var waves: Array
var current_wave: int = 0
var wave_count: int

## wave properties
var wave: Array
var current_group: int = 0
var group_count: int

## group properties
var group: Array
var current_enemy: int = 0
var enemy_type: String
var enemy_count: int
var group_delay: float

## enemy properties
var enemy_path_follow: PathFollow2D
var enemy: Area2D
var spawn_delay: float


## set spawner values according to stats
func init(_parent: Node2D) -> void:
	parent = _parent
	wave_data = parent.wave_data
	wave_set = parent.wave_set
	canvas = parent.canvas
	
	init_layers()
	get_waves()
	prepare_waves()


## init layers for spawning
func init_layers() -> void:
	ground_enemies = canvas.find_child("GroundEnemyPath")
	ground_vehicles = canvas.find_child("GroundVehiclePath")
	ground_bosses = canvas.find_child("GroundBossPath")
	air_enemies = canvas.find_child("AirEnemyPath")
	air_vehicles = canvas.find_child("AirVehiclePath")
	air_bosses = canvas.find_child("AirBossPath")


## determines which wave set to use for the map
func get_waves() -> void:
	match wave_set:
		"debug":
			waves = wave_data.debug_waves
			print("debug waves!")
		"story":
			waves = wave_data.story_waves
			print("story waves!")
		"standard":
			waves = wave_data.standard_waves
			print("standard waves!")
		"x2":
			waves = wave_data.x2_waves
			print("x2 waves!")
		"x10":
			waves = wave_data.x10_waves
			print("x10 waves!")
		"extraction":
			waves = wave_data.extraction_waves
			print("extraction waves!")
		"eggs":
			waves = wave_data.eggs_waves
			print("eggs waves!")
		_:
			printerr("The %s set of waves doesn't exist! How did you even select that?" % wave_set)


## gets the wave count
func prepare_waves() -> void:
	wave_count = waves.size()


## picks the current wave, and gets the group count
func prepare_wave() -> void:
	wave = waves[current_wave]
	group_count = wave.size()


## get the info from the current group
func prepare_group() -> void:
	group = wave[current_group]
	enemy_type = group[0]
	enemy_count = group[1]
	spawn_delay = group[2]
	group_delay = group[3]


## iterate to next wave
func next_wave() -> void:
	current_group = 0
	current_wave += 1


## iterate to next group
func next_group() -> void:
	current_enemy = 0
	current_group += 1


## ensure enemy exists in the list of enemies
func verify_enemy() -> void:
	if enemy_type not in enemies:
		printerr("The enemy type %s does not exist!" % enemy_type)
		return


## instantiate enemy, and assign it its canvas layer
func spawn_enemy() -> void:
	enemy_path_follow = enemies[enemy_type].instantiate()
	enemy = enemy_path_follow.get_child(0)
	assign_path()
	current_enemy += 1


## determine the canvas layer that the enemy is spawned on
func assign_path() -> void:
	if enemy.is_in_group("ground_enemies"):
		path = ground_enemies
	elif enemy.is_in_group("ground_vehicles"):
		path = ground_vehicles
	elif enemy.is_in_group("ground_bosses"):
		path = ground_bosses
	elif enemy.is_in_group("air_enemies"):
		path = air_enemies
	elif enemy.is_in_group("air_vehicles"):
		path = air_vehicles
	elif enemy.is_in_group("air_bosses"):
		path = air_bosses
	else:
		printerr("The enemy %s is not in an enemy group!" % enemy.name)
	
	path.add_child(enemy_path_follow)
