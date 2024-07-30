class_name StandardHUD
extends CanvasLayer
##TODO desc


@export var exit: Exit
@export var spawner: Spawner
@export var starting_coins: int = 10000

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
	GlobalScripts.connect_signal(MoneyManager, "coins_changed", self, "_on_coins_changed")
	
	# set the visibility layer to the same as whatever the UI layer is
	self.layer = ui_layer.layer
	
	# init wave label
	wave_label.text = ("Wave: %s" % (spawner.spawning.current_wave + 1))
	
	# init healthbar
	health_bar.health_component = exit.health
	health_bar.init(exit)
	
	# init coins and label
	MoneyManager.set_coins(starting_coins)
	amount.text = MoneyManager.get_current_coins()
	
	# init build menu
	build_menu.hud = self


## when the wave is complete, update the wave counter label
func _on_wave_completed() -> void:
	wave_label.text = ("Wave: %s" % (spawner.spawning.current_wave + 1))


## when the coin value changes, update the label
func _on_coins_changed() -> void:
	amount.text = MoneyManager.get_current_coins()
