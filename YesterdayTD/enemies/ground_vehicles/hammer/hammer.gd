class_name Hammer
extends Enemy


@export var stats: EnemyStats

@onready var hitbox := $Hitbox as Hitbox
@onready var animations := $Animations as AnimatedSprite2D
@onready var state_machine := $StateMachine as StateMachine
@onready var coin_value := $CoinValueComponent as CoinValueComponent
@onready var damage := $DamageComponent as DamageComponent
@onready var health := $HealthComponent as HealthComponent
@onready var hit_flash := $HitFlashComponent as HitFlashComponent
@onready var layers := $LayersComponent as LayersComponent
@onready var path_movement := $PathMovementComponent as PathMovementComponent
@onready var sound := $SoundComponent as SoundComponent
@onready var speed := $SpeedComponent as SpeedComponent


# init state machine and components
func _ready() -> void:
	GlobalScripts.verify(self, stats, "stats")
	
	coin_value.init(self)
	damage.init(self)
	health.init(self)
	hit_flash.init(self)
	layers.init(self)
	path_movement.init(self)
	sound.init(self)
	speed.init(self)
	state_machine.init(self)
