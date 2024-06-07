class_name Spawner
extends Node2D


@export var wave_data: WaveData
@export var ground_enemies: Path2D
@export var ground_vehicles: Path2D
@export var ground_bosses: Path2D
@export var air_enemies: Path2D
@export var air_vehicles: Path2D
@export var air_bosses: Path2D
enum WaveSets {debug, story, standard, x2, x10, extraction, eggs,}
@export var wave_set: WaveSets
@export var wave_delay := 1.0

@onready var state_machine := $StateMachine as StateMachine
@onready var wave_timer := $WaveTimer as Timer
@onready var group_timer := $GroupTimer as Timer
@onready var spawn_timer := $SpawnTimer as Timer

var debug_waves := []
var story_waves := []
var standard_waves := []
var x2_waves := []
var x10_waves := []
var extraction_waves := []
var eggs_waves := []

var waves := [[{}]]

var wave := [{}]
var current_wave := 0
var wave_count: int

var group := {}
var current_group := 0
var group_count: int

var current_enemy := 0
var enemy_type: String
var enemy_count: int

var spawn_delay: float
var group_delay: float


## init state machine and components
func _ready() -> void:
	GlobalScripts.verify(self, wave_data, "wave_data")
	GlobalScripts.verify(self, ground_enemies, "ground_enemies")
	GlobalScripts.verify(self, ground_vehicles, "ground_vehicles")
	GlobalScripts.verify(self, ground_bosses, "ground_bosses")
	GlobalScripts.verify(self, air_enemies, "air_enemies")
	GlobalScripts.verify(self, air_vehicles, "air_vehicles")
	GlobalScripts.verify(self, air_bosses, "air_bosses")
	
	get_waves()
	state_machine.init(self)


## determines which wave set to use for the map
func get_waves() -> void:
	match wave_set:
		0:
			waves = wave_data.debug_waves
			print("debug waves!")
		1:
			waves = wave_data.story_waves
			print("story waves!")
		2:
			waves = wave_data.standard_waves
			print("standard waves!")
		3:
			waves = wave_data.x2_waves
			print("x2 waves!")
		4:
			waves = wave_data.x10_waves
			print("x10 waves!")
		5:
			waves = wave_data.extraction_waves
			print("extraction waves!")
		6:
			waves = wave_data.eggs_waves
			print("eggs waves!")
## FIXME do wave data better
