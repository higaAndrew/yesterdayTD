class_name HitFlashComponent
extends Node


@export var animations: AnimatedSprite2D
@export var flash_color: Color = Color.WHITE
@export_range(0.0, 1.0) var flash_duration: float = 0.05
@export_range(0.0, 1.0) var flash_modifier: float = 0.25

var parent: Area2D
var hit_flash_shader = preload("res://enemies/hit_flash.gdshader")


## set parent and verify animations
func init(_parent: Area2D) -> void:
	parent = _parent
	
	GlobalScripts.verify(parent, animations, "animations")
	
	if is_instance_valid(animations.material):
		printerr("%s already has a material/shader!" % parent)
		return
	else:
		animations.material = ShaderMaterial.new()
		animations.material.shader = hit_flash_shader
		animations.material.set_shader_parameter("flash_color", flash_color)


## trigger hit flash
func start_flash() -> void:
	animations.material.set_shader_parameter("flash_modifier", flash_modifier)
	var flash_timer = get_tree().create_timer(flash_duration, false)
	flash_timer.connect("timeout", _on_flash_timer_timeout)


func end_flash() -> void:
	animations.material.set_shader_parameter("flash_modifier", 0.0)


func _on_flash_timer_timeout() -> void:
	end_flash()
