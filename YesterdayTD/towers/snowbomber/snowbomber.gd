class_name Snowbomber
extends Tower


@export var stats: TowerStats

@export_group("Attacks")
@export_subgroup("Attack0")
@export var attack0_scene: PackedScene
@export var attack0_stats: AttackStats
@onready var attack0_cooldown_timer := $SnowbombCooldownTimer as Timer

@onready var detection_range := $DetectionRange as Area2D
@onready var range_hitbox := %RangeHitbox as Hitbox
@onready var animations := $Animations as AnimatedSprite2D
@onready var sightline := $Sightline as RayCast2D
@onready var state_machine := $StateMachine as StateMachine
@onready var snowbomb_state_machine := $SnowbombStateMachine as StateMachine
@onready var attack := $AttackComponent as AttackComponent
@onready var attack_interactions := $AttackInteractionsComponent as AttackInteractionsComponent
@onready var cooldown := $CooldownComponent as CooldownComponent
@onready var outline := $OutlineComponent as OutlineComponent
@onready var price := $PriceComponent as PriceComponent
@onready var range_component := $RangeComponent as RangeComponent
@onready var targets := $TargetsComponent as TargetsComponent
@onready var ui := $UIComponent as UIComponent


## init state machines and components
func _ready() -> void:
	GlobalScripts.verify(self, stats, "stats")
	GlobalScripts.verify(self, attack0_scene, "snowbomb_scene")
	GlobalScripts.verify(self, attack0_stats, "attack0_stats")
	
	attack.init(self)
	attack_interactions.init(self)
	cooldown.init(self)
	outline.init(self)
	price.init(self)
	range_component.init(self)
	targets.init(self)
	ui.init(self)
	state_machine.init(self)
	snowbomb_state_machine.init(self)
