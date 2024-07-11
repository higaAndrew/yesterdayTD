class_name HealthBar
extends Control


@export var health_component: HealthComponent

var parent: Area2D
var tween: Tween

@onready var health_bar_under := $HealthBarUnder as TextureProgressBar
@onready var health_bar_over := $HealthBarOver as TextureProgressBar


func init(_parent: Area2D) -> void:
	parent = _parent
	
	GlobalScripts.verify(parent, health_component, "health_component")
	GlobalScripts.connect_signal(health_component, "took_damage", self, "_on_took_damage")
	GlobalScripts.connect_signal(health_component, "healed", self, "_on_healed")
	
	health_bar_over.max_value = health_component.current_health
	health_bar_over.value = health_component.current_health
	
	health_bar_under.max_value = health_bar_over.max_value
	health_bar_under.value = health_bar_over.value


func _on_took_damage(_amount: float, current_health: float) -> void:
	health_bar_over.value = current_health
	if is_instance_valid(tween):
		tween.kill()
	tween = self.create_tween().set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(health_bar_under, "value", current_health, 0.4)


func _on_healed(_amount: float, current_health: float) -> void:
	health_bar_over.value = current_health
