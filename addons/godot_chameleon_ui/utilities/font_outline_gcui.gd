@tool
class_name FontOutlineGCUI
extends RefCounted

enum PRESET {
	FROM_THEME,
	NONE,
	SMALL,
	MEDIUM,
}

const PRESET_DEFINITIONS: Dictionary[PRESET, int] = {
	PRESET.SMALL: 1,
	PRESET.MEDIUM: 3
}


static func custom(control: Control, color: Color, outline_size: float) -> void:
	if !control:
		return
	_update_outline(control, color, outline_size)


static func preset(control: Control, color: Color, preset: PRESET) -> void:
	if !control:
		return
	if preset == PRESET.NONE || preset != PRESET.FROM_THEME:
		_remove_outline(control)
	else:
		_update_outline(control, color, PRESET_DEFINITIONS.get(preset))


static func _update_outline(control: Control, color: Color, outline_size: float) -> void:
	if !control:
		return
	control.add_theme_color_override("font_outline_color", color)
	control.add_theme_constant_override("outline_size", outline_size)


static func _remove_outline(control: Control) -> void:
	if !control:
		return
	control.remove_theme_color_override("font_outline_color")
	control.remove_theme_constant_override("outline_size")
