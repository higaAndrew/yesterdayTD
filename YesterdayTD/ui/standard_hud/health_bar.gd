class_name HealthBar
extends Control


@export var health_component: HealthComponent

@export_category("Health Bar Settings")

@export_group("Health Bar Colors")
@export var over_bar_color: Color = Color.GREEN
@export var under_bar_color: Color = Color.WHITE
@export_subgroup("Status Colors")
@export var status_colors_enabled: bool = true
@export var caution_color: Color = Color.GOLD
@export_range(0.0, 1.0) var caution_zone: float = 0.5
@export var danger_color: Color = Color.RED
@export_range(0.0, 1.0) var danger_zone: float = 0.25
@export_subgroup("Danger Pulse")
@export var danger_pulse_enabled: bool = true
@export var pulse_color: Color = Color.DARK_RED
@export var pulse_duration: float = 0.5

@export_group("Visible Damage")
@export var visible_damage_enabled: bool = true
@export var damage_delay: float = 0.15
@export var damage_duration: float = 0.4
@export_subgroup("Visible Healing")
@export var visible_healing_enabled: bool = true
@export var healing_delay: float = 0.15
@export var healing_duration: float = 0.4

@export_group("Health Bar Shake")
@export var health_bar_shake_enabled: bool = true
@export var shake_intensity: float = 10
@export var shake_duration: float = 2
@export var shake_speed: float = 10

var parent: Area2D
var current_health: float
var pulse_tween: Tween
var pulsing: bool = false
var damage_tween: Tween
var healing_tween: Tween

@onready var health_bar_under := $HealthBarUnder as TextureProgressBar
@onready var health_bar_over := $HealthBarOver as TextureProgressBar
@onready var damage_timer := $DamageTimer as Timer
@onready var healing_timer := $HealingTimer as Timer
@onready var shaker := $ShakerComponent as ShakerComponent


## set health bar bar values according to health component
func init(_parent: Area2D) -> void:
	parent = _parent
	
	GlobalScripts.verify(parent, health_component, "health_component")
	GlobalScripts.connect_signal(health_component, "took_damage", self, "_on_took_damage")
	GlobalScripts.connect_signal(health_component, "healed", self, "_on_healed")
	GlobalScripts.connect_signal(damage_timer, "timeout", self, "_on_damage_timer_timeout")
	GlobalScripts.connect_signal(healing_timer, "timeout", self, "_on_healing_timer_timeout")
	
	health_bar_over.tint_progress = over_bar_color
	health_bar_over.max_value = health_component.current_health
	health_bar_over.value = health_component.current_health
	
	health_bar_under.tint_progress = under_bar_color
	health_bar_under.max_value = health_bar_over.max_value
	health_bar_under.value = health_bar_over.value
	
	if damage_delay > 0:
		damage_timer.set_wait_time(damage_delay)
	if healing_delay > 0:
		healing_timer.set_wait_time(healing_delay)
	
	shaker.intensity = shake_intensity
	shaker.duration = shake_duration
	shaker.shake_speed = shake_speed


## when the parent takes damage, run active methods
func _on_took_damage(_amount: float, _current_health: float) -> void:
	current_health = _current_health
	health_bar_over.value = current_health
	
	if status_colors_enabled:
		status_colors()
	
	if visible_damage_enabled:
		visible_damage()
	else:
		health_bar_under.value = current_health
	
	if health_bar_shake_enabled:
		health_bar_shake()
		


## when the parent is healed, run active methods
func _on_healed(_amount: float, _current_health: float) -> void:
	current_health = _current_health
	health_bar_under.value = current_health
	
	if status_colors_enabled:
		status_colors()
	
	if visible_healing_enabled:
		visible_healing()
	else:
		health_bar_over.value = current_health


## HEALTH BAR COLOR METHODS

## change the color of the health bar at certain percentages
func status_colors() -> void:
	if current_health <= health_bar_over.max_value * danger_zone:
		if danger_pulse_enabled:
			danger_pulse()
		else:
			health_bar_over.tint_progress = danger_color
	
	else:
		if danger_pulse_enabled:
			stop_pulse()
		if current_health <= health_bar_over.max_value * caution_zone:
			health_bar_over.tint_progress = caution_color
		else:
			health_bar_over.tint_progress = over_bar_color


## pulse the health bar's color at a certain percentage
## if already pulsing, continue to do so
func danger_pulse() -> void:
	if current_health <= 0.0:
		stop_pulse()
		return
	if not pulsing:
		health_bar_over.tint_progress = danger_color
		pulse_tween = self.create_tween().set_loops().set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
		pulse_tween.tween_property(health_bar_over, "tint_progress", pulse_color, pulse_duration)
		pulse_tween.tween_property(health_bar_over, "tint_progress", danger_color, pulse_duration)
		pulsing = true
	else:
		pass


## if pulsing, stop
func stop_pulse() -> void:
	if is_instance_valid(pulse_tween):
		pulsing = false
		pulse_tween.kill()


## VISIBLE DAMAGE METHODS

## if damage tween is playing, kill it, then start the damage timer
func visible_damage() -> void:
	if is_instance_valid(damage_tween):
		damage_tween.kill()
	
	if damage_delay > 0.0:
		damage_timer.start()
	else:
		_on_damage_timer_timeout()

## create the tween for the health damage animation
func _on_damage_timer_timeout() -> void:
	damage_tween = self.create_tween().set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	damage_tween.tween_property(health_bar_under, "value", current_health, damage_duration)


## VISIBLE HEALING METHODS

## if healing tween is playing, kill it, then start the healing timer
func visible_healing() -> void:
	if is_instance_valid(healing_tween):
		healing_tween.kill()
	
	if healing_delay > 0.0:
		healing_timer.start()
	else:
		_on_healing_timer_timeout()


## create the tween for the health healing animation
func _on_healing_timer_timeout() -> void:
	healing_tween = self.create_tween().set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	healing_tween.tween_property(health_bar_over, "value", current_health, healing_duration)


## HEALTH BAR SHAKE METHODS
func health_bar_shake() -> void:
	if !shaker.is_playing:
		shaker.play_shake()
	else:
		shaker.set_progress(0.0)
