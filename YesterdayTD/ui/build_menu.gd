class_name BuildMenu
extends Control

@export var hud: CanvasLayer

@onready var button_1 := %Button1 as Button
@onready var tower_name_label := %TowerNameLabel as Label
@onready var tower_list := %TowerList as GridContainer

@onready var snowballer := %Snowballer as Button
@onready var snowbomber := %Snowbomber as Button
@onready var debug_tower := %DebugTower as Button

@onready var next_wave_button := %NextWaveButton as Button
@onready var settings_button := %SettingsButton as Button
@onready var state_machine := $StateMachine as StateMachine
@onready var tower_builder := $TowerBuilderComponent as TowerBuilderComponent

func _ready() -> void:
	state_machine.init(self)
	tower_builder.init(self)
