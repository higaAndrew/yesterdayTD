class_name Snowbomb
extends Attack


@export var stats: AttackStats

@export_group("Attacks")
@export_subgroup("Attack0")
@export var attack0_scene: PackedScene
@export var attack0_stats: AttackStats

@onready var hitbox := $Hitbox as Hitbox
@onready var animations := $Animations as AnimatedSprite2D
@onready var hit_vfx := $HitVFX as AnimatedSprite2D
@onready var lifespan_timer := $LifespanTimer as Timer
@onready var pierce_cooldown_timer := $PierceCooldownTimer as Timer
@onready var snowbomb_explosion_state_machine := $SnowbombExplosionStateMachine as StateMachine
@onready var attack := $AttackComponent as AttackComponent
@onready var attack_interactions := $AttackInteractionsComponent as AttackInteractionsComponent
@onready var damage := $DamageComponent as DamageComponent
@onready var pierce := $PierceComponent as PierceComponent
@onready var sound := $SoundComponent as SoundComponent
@onready var speed := $SpeedComponent as SpeedComponent
@onready var velocity := $VelocityComponent as VelocityComponent


## init state machine and components
func _ready() -> void:
	GlobalScripts.verify(self, stats, "stats")
	GlobalScripts.verify(self, attack0_scene, "snowbomb explosion scene")
	GlobalScripts.verify(self, attack0_stats, "snowbomb explosion stats")
	
	attack.init(self)
	attack_interactions.init(self)
	damage.init(self)
	pierce.init(self)
	sound.init(self)
	speed.init(self)
	velocity.init(self)
	snowbomb_explosion_state_machine.init(self)
