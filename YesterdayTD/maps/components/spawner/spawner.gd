class_name Spawner
extends Node2D

@export var canvas: Canvas
@export var wave_data: WaveData
@export_enum("debug", "story", "standard", "x2", "x10", "extraction", "eggs") var wave_set: String = "debug"
@export_range(0.0001, 60) var wave_delay: float

@onready var wave_timer := $WaveTimer as Timer
@onready var group_timer := $GroupTimer as Timer
@onready var spawn_timer := $SpawnTimer as Timer
@onready var state_machine := $StateMachine as StateMachine
@onready var spawning := $SpawningComponent as SpawningComponent


## init state machine and components
func _ready() -> void:
	GlobalScripts.verify(self, wave_data, "wave_data")
	
	state_machine.init(self)
	spawning.init(self)
