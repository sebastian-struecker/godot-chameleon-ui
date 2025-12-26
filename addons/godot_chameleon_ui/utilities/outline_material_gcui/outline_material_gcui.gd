@tool
class_name OutlineMaterialGCUI
extends Node

const MATERIAL = preload("uid://xeuscm7vvobj")
const SHADER_PARAMETER = "width"

@export var control: Control:
	set(value):
		var temp = control
		control = value
		if value:
			var material = MATERIAL.duplicate(true)
			control.material = material
			_control_material = material
		else:
			_control_material = null
		if temp:
			temp.material = null
@export_range(0, 10, 0.01) var width: float = 1.0:
	set(value):
		width = value
		_adjust_width(value)

var _control_material: ShaderMaterial


func _adjust_width(_width: float) -> void:
	if !control:
		return
	if !_control_material:
		return
	_control_material.set_shader_parameter(SHADER_PARAMETER, _width)
