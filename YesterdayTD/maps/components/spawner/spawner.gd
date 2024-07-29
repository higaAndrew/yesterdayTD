class_name Spawner
extends Node2D


signal wave_timer_timeout
signal wave_timer_started
signal wave_spawns_finished

@export var canvas: Canvas
@export var wave_data: WaveData
@export_enum("debug", "story", "standard", "x2", "x10", "extraction", "eggs") var wave_set: String = "debug"
@export_range(0.001, 60) var wave_delay: float

@onready var group_timer := $GroupTimer as Timer
@onready var spawn_timer := $SpawnTimer as Timer
@onready var state_machine := $StateMachine as StateMachine
@onready var spawning := $SpawningComponent as SpawningComponent


## init state machine and components
func _ready() -> void:
	GlobalScripts.verify(self, canvas, "canvas")
	GlobalScripts.verify(self, wave_data, "wave_data")
	
	spawning.init(self)
	state_machine.init(self)
