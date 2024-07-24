class_name Spawner
extends Node2D


signal wave_timer_timeout
signal wave_timer_started
signal wave_completed

@export var canvas: Canvas
@export var wave_data: WaveData
@export_enum("debug", "story", "standard", "x2", "x10", "extraction", "eggs") var wave_set: String = "debug"
@export_range(0.001, 60) var wave_delay: float

@onready var wave_timer := $WaveTimer as Timer
@onready var group_timer := $GroupTimer as Timer
@onready var spawn_timer := $SpawnTimer as Timer
@onready var state_machine := $StateMachine as StateMachine
@onready var spawning := $SpawningComponent as SpawningComponent


## init state machine and components
func _ready() -> void:
	GlobalScripts.verify(self, canvas, "canvas")
	GlobalScripts.verify(self, wave_data, "wave_data")
	
	GlobalScripts.connect_signal(wave_timer, "timeout", self, "_on_wave_timer_timeout")
	GlobalScripts.connect_signal(state_machine.find_child("SpawnWave"), "wave_timer_started", self, "_on_wave_timer_started")
	GlobalScripts.connect_signal(spawning, "wave_completed", self, "_on_wave_completed")
	
	spawning.init(self)
	state_machine.init(self)


## signal when wave timer times out
## used for hiding the wave timer
func _on_wave_timer_timeout() -> void:
	wave_timer_timeout.emit()


## signal that the wave timer has started
## used for displaying the wave timer
func _on_wave_timer_started() -> void:
	wave_timer_started.emit()


## signal that a wave has been completed
## used for iterating the wave counter
func _on_wave_completed() -> void:
	wave_completed.emit()
