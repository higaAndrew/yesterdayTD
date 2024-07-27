class_name StandardHUD
extends CanvasLayer
##TODO desc


@export var exit: Exit
@export var spawner: Spawner
@export var starting_coins: int = 10000

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
	GlobalScripts.connect_signal(MapManager, "coins_changed", self, "_on_coins_changed")
	
	# set the visibility layer to the same as whatever the UI layer is
	self.layer = ui_layer.layer
	
	# init wave label
	wave_label.text = ("Wave: %s" % (spawner.spawning.current_wave + 1))
	
	# init healthbar
	health_bar.health_component = exit.health
	health_bar.init(exit)
	
	# init coins and label
	MapManager.set_coins(starting_coins)
	amount.text = MapManager.get_current_coins()
	
	# init build menu
	build_menu.hud = self


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


func _on_coins_changed() -> void:
	amount.text = MapManager.get_current_coins()
