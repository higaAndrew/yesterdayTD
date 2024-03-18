class_name Objective
extends Area2D

@onready var health_component := $HealthComponent as HealthComponent
@onready var hitbox_component := $HitboxComponent as HitboxComponent
@onready var collision_shape := $CollisionShape2D as CollisionShape2D
@onready var life_lost := $LifeLost as AudioStreamPlayer


func _ready() -> void:
	health_component.initialize_health()
	health_component.took_damage.connect(_health_changed)
	health_component.health_zero.connect(_die)
	hitbox_component.enemy_exited.connect(_enemy_exited)


func _health_changed(current_health: float) -> void:
	print("The objective now has %s health remaining!" % current_health)


func _die() -> void:
	print("The objective is dead!")


func _enemy_exited(enemy: Node2D) -> void:
	# if an enemy has passed the objective without being killed, the objective takes damage
	health_component.take_damage(enemy.damage_component.damage)
	# check to see if enemy is a child of PathFollow2D
	var enemy_parent = enemy.get_parent()
	if enemy_parent is PathFollow2D:
		enemy_parent.queue_free()
		life_lost.play()
	else:
		enemy.queue_free()

