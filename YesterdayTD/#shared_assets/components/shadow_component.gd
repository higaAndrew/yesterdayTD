class_name ShadowComponent
extends Node


var parent: Area2D
var shadow_shader: Shader = preload("res://#shared_assets/shaders/shadow.gdshader")


## set range values according to stats
func init(_parent: Area2D) -> void:
	parent = _parent


func create_shadows() -> void:
	if is_instance_valid(parent.material):
		printerr("%s already has a material/shader!" % parent)
		return
	else:
		parent.material = ShaderMaterial.new()
		parent.material.shader = shadow_shader
