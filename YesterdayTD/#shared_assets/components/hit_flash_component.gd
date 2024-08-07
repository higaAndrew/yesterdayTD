class_name HitFlashComponent
extends Node

## TODO only flash if not dying animation

@export var animations: AnimatedSprite2D
@export var flash_color: Color = Color.WHITE
@export_range(0.0, 1.0) var flash_duration: float = 0.05
@export_range(0.0, 1.0) var flash_intensity: float = 0.25

var parent: Area2D
var hit_flash_shader: Shader = preload("res://#shared_assets/shaders/hit_flash.gdshader")


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
	animations.material.set_shader_parameter("flash_intensity", flash_intensity)
	var flash_timer = get_tree().create_timer(flash_duration, false)
	flash_timer.connect("timeout", _on_flash_timer_timeout)


## end the hit flash
func end_flash() -> void:
	animations.material.set_shader_parameter("flash_intensity", 0.0)


## if the flash timer ends, end the flash
func _on_flash_timer_timeout() -> void:
	end_flash()
