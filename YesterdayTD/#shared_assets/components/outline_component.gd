class_name OutlineComponent
extends Node


@export var animations: AnimatedSprite2D
@export var outline_color: Color = Color.WHITE
@export var outline_width: float = 6.0
@export var outline_pattern: int = 1
@export var outline_inside: bool = false
@export var outline_margins: bool = true
@export var number_images: Vector2 = Vector2(7, 6)

var parent: Area2D
var outline_shader: Shader = preload("res://#shared_assets/shaders/outline_sprite_sheet.gdshader")


## set parent and verify animations
func init(_parent: Area2D) -> void:
	parent = _parent
	
	GlobalScripts.verify(parent, animations, "animations")
	
	if is_instance_valid(animations.material):
		printerr("%s already has a material/shader!" % parent)
		return
	else:
		animations.material = ShaderMaterial.new()
		animations.material.shader = outline_shader
		animations.material.set_shader_parameter("color", outline_color)
		animations.material.set_shader_parameter("width", outline_width)
		animations.material.set_shader_parameter("pattern", outline_pattern)
		animations.material.set_shader_parameter("inside", outline_inside)
		animations.material.set_shader_parameter("add_margins", outline_margins)
		animations.material.set_shader_parameter("number_of_images", number_images)


## show outline
func enable_outline() -> void:
	animations.material.set_shader_parameter("width", outline_width)


## remove outline
func disable_outline() -> void:
	animations.material.set_shader_parameter("width", 0.0)


## toggle outline
func toggle_outline() -> void:
	if animations.material.get_shader_parameter("width") == outline_width:
		disable_outline()
	else:
		enable_outline()


## change the outline's color to a given color
func change_outline_color(new_color: Color) -> void:
	animations.material.set_shader_parameter("color", new_color)


## restore the outline's color to default
func restore_outline_color() -> void:
	animations.material.set_shader_parameter("color", outline_color)
