@tool
class_name TransparencyMaterialGCUI
extends RefCounted

const MATERIAL = preload("uid://b8u0r26jmxlgj")
const SHADER_PARAMETER = "transparency"


static func transparency(control: Control, transparency: float) -> void:
	if !control:
		return
	if control.material == null:
		var material = MATERIAL.duplicate(true)
		control.material = material
	if control.material is ShaderMaterial:
		control.material.set_shader_parameter(SHADER_PARAMETER, transparency)
