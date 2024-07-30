class_name StandardHUD
extends CanvasLayer
##TODO desc


@export var exit: Exit
@export var spawner: Spawner
@export var starting_coin_count: int = 10000

var ui_layer: CanvasLayer

@onready var wave_label := %WaveLabel as Label
@onready var health_bar := %HealthBar as HealthBar
@onready var amount := %Amount as Label
@onready var build_menu := %BuildMenu as BuildMenu


## init components
func _ready() -> void:
	ui_layer = find_parent("UI")
	
	GlobalScripts.verify(self, exit, "exit")
	GlobalScripts.verify(self, spawner, "spawner")
	
	GlobalScripts.connect_signal(EnemyManager, "wave_completed", self, "_on_wave_completed")
	GlobalScripts.connect_signal(MoneyManager, "coin_count_changed", self, "_on_coin_count_changed")
	
	# set the visibility layer to the same as whatever the UI layer is
	self.layer = ui_layer.layer
	
	# init wave label
	wave_label.text = ("Wave: %s" % (spawner.spawning.current_wave + 1))
	
	# init healthbar
	health_bar.health_component = exit.health
	health_bar.init(exit)
	
	# init coin count and label
	MoneyManager.set_coin_count(starting_coin_count)
	amount.text = MoneyManager.get_current_coin_count()
	
	# init build menu
	build_menu.hud = self


## when the wave is complete, update the wave counter label
func _on_wave_completed() -> void:
	wave_label.text = ("Wave: %s" % (spawner.spawning.current_wave + 1))


## when the coin value changes, update the label
func _on_coin_count_changed() -> void:
	amount.text = MoneyManager.get_current_coin_count()
