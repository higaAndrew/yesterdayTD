class_name StandardHUD
extends CanvasLayer


@export var exit: Exit
@export var spawner: Spawner

var ui_layer: CanvasLayer
var wave_timer_is_active: bool = true

@onready var wave_label := %WaveLabel as Label
@onready var next_wave := %NextWave as PanelContainer
@onready var countdown := %Countdown as Label
@onready var wave_timer := %WaveTimer as Timer
@onready var health_bar := %HealthBar as HealthBar
@onready var amount := %Amount as Label
@onready var build_menu := %BuildMenu as BuildMenu


## init components
func _ready() -> void:
	ui_layer = find_parent("UI")
	
	GlobalScripts.verify(self, exit, "exit")
	GlobalScripts.verify(self, spawner, "spawner")
	
	GlobalScripts.connect_signal(spawner, "wave_timer_started", self, "_on_wave_timer_started")
	GlobalScripts.connect_signal(spawner, "wave_timer_timeout", self, "_on_wave_timer_timeout")
	GlobalScripts.connect_signal(spawner, "wave_completed", self, "_on_wave_completed")
	
	# set the visibility layer to the same as whatever the UI layer is
	self.layer = ui_layer.layer
	
	# init healthbar
	health_bar.health_component = exit.health
	health_bar.init(exit)
	
	# init build menu
	build_menu.hud = self
	
	wave_label.text = ("Wave: %s" % (spawner.spawning.current_wave + 1))


## show the wave timer if it is active
func _process(_delta: float) -> void:
	if wave_timer_is_active:
		countdown.text = str(int(spawner.wave_timer.time_left))


## when the wave timer starts, make it visible
func _on_wave_timer_started() -> void:
	wave_timer_is_active = true
	next_wave.show()


## when the wave timer ends, hide it
func _on_wave_timer_timeout() -> void:
	wave_timer_is_active = false
	next_wave.hide()


## when the wave is complete, update the wave counter label
func _on_wave_completed() -> void:
	wave_label.text = ("Wave: %s" % (spawner.spawning.current_wave + 1))
