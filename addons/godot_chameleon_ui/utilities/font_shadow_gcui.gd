@tool
class_name FontShadowGCUI
extends RefCounted

enum PRESET {
	FROM_THEME,
	NONE,
	SLIGHT,
}

const PRESET_DEFINITIONS: Dictionary[PRESET, Array] = {
	PRESET.SLIGHT: [1, 1, 1]
}


static func custom(control: Control, color: Color, offset_x: float, offset_y: float, outline_size: float) -> void:
	if !control:
		return
	_update_shadow(control, color, offset_x, offset_y, outline_size)


static func preset(control: Control, color: Color, preset: PRESET) -> void:
	if !control:
		return
	if preset == PRESET.NONE || preset == PRESET.FROM_THEME:
		_remove_shadow(control)
	else:
		_update_shadow(control, color, PRESET_DEFINITIONS.get(preset)[0], PRESET_DEFINITIONS.get(preset)[1], PRESET_DEFINITIONS.get(preset)[2])


static func _update_shadow(control: Control, color: Color, offset_x: float, offset_y: float, outline_size: float) -> void:
	if !control:
		return
	control.add_theme_color_override("font_shadow_color", color)
	control.add_theme_constant_override("shadow_offset_x", offset_x)
	control.add_theme_constant_override("shadow_offset_y", offset_y)
	control.add_theme_constant_override("shadow_outline_size", outline_size)


static func _remove_shadow(control: Control) -> void:
	if !control:
		return
	control.remove_theme_color_override("font_shadow_color")
	control.remove_theme_constant_override("shadow_offset_x")
	control.remove_theme_constant_override("shadow_offset_y")
	control.remove_theme_constant_override("shadow_outline_size")
