class_name BuildMenu
extends Control


@export var hud: CanvasLayer

@onready var button_1 := %Button1 as Button
@onready var tower_name_label := %TowerNameLabel as Label
@onready var tower_list := %TowerList as GridContainer

@onready var snowballer_button := %SnowballerButton as Button
@onready var snowbomber_button := %SnowbomberButton as Button
@onready var debug_tower_button := %DebugTowerButton as Button

@onready var next_wave_button := %NextWaveButton as Button
@onready var settings_button := %SettingsButton as Button
@onready var state_machine := $StateMachine as StateMachine
@onready var tower_builder := $TowerBuilderComponent as TowerBuilderComponent


## init state machine and components
func _ready() -> void:
	tower_builder.init(self)
	state_machine.init(self)
