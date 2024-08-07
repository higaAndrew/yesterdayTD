class_name DebugProjectile
extends Attack


@export var stats: AttackStats

@onready var hitbox := $Hitbox as Hitbox
@onready var animations := $Animations as AnimatedSprite2D
@onready var hit_vfx := $HitVFX as AnimatedSprite2D
@onready var lifespan_timer := $LifespanTimer as Timer
@onready var state_machine := $StateMachine as StateMachine
@onready var attack_interactions := $AttackInteractionsComponent as AttackInteractionsComponent
@onready var damage := $DamageComponent as DamageComponent
@onready var pierce := $PierceComponent as PierceComponent
@onready var sound := $SoundComponent as SoundComponent
@onready var speed := $SpeedComponent as SpeedComponent
@onready var velocity := $VelocityComponent as VelocityComponent


## init state machine and components
func _ready() -> void:
	GlobalScripts.verify(self, stats, "stats")
	
	attack_interactions.init(self)
	damage.init(self)
	pierce.init(self)
	sound.init(self)
	speed.init(self)
	velocity.init(self)
	state_machine.init(self)
