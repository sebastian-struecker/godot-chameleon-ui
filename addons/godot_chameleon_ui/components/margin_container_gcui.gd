@tool
class_name MarginContainerGCUI
extends MarginContainer

enum PRESET {
	CUSTOM,
	NONE,
	XS,
	S,
	M,
	L,
	XL,
}

const PRESET_DEFINITIONS: Dictionary[PRESET, Array] = {
	PRESET.CUSTOM: [0, 0, 0, 0],
	PRESET.NONE: [0, 0, 0, 0],
	PRESET.XS: [4, 4, 4, 4],
	PRESET.S: [8, 8, 8, 8],
	PRESET.M: [62, 35, 62, 35],
	PRESET.L: [110, 62, 110, 62],
	PRESET.XL: [200, 110, 200, 110]
}

@export var preset: PRESET = PRESET.NONE:
	set(value):
		preset = value
		_use_preset(value)
## Set theme overrides for the margin[br]
## [code]x: Left[/code][br]
## [code]y: Top[/code][br]
## [code]z: Right[/code][br]
## [code]w: Bottom[/code][br]
@export var margins: Vector4i = Vector4i.ZERO:
	set(value):
		margins = value
		if preset == PRESET.CUSTOM:
			_update_margins()


func _update_margins() -> void:
	if preset == PRESET.NONE:
		_remove_overrides()
		return
	if preset == PRESET.CUSTOM:
		add_theme_constant_override("margin_left", margins.x)
		add_theme_constant_override("margin_top", margins.y)
		add_theme_constant_override("margin_right", margins.z)
		add_theme_constant_override("margin_bottom", margins.w)
	else:
		add_theme_constant_override("margin_left", PRESET_DEFINITIONS.get(preset)[0])
		add_theme_constant_override("margin_top", PRESET_DEFINITIONS.get(preset)[1])
		add_theme_constant_override("margin_right", PRESET_DEFINITIONS.get(preset)[2])
		add_theme_constant_override("margin_bottom", PRESET_DEFINITIONS.get(preset)[3])


func _use_preset(_preset: PRESET) -> void:
	if _preset != PRESET.CUSTOM:
		margins.x = PRESET_DEFINITIONS.get(_preset)[0]
		margins.y = PRESET_DEFINITIONS.get(_preset)[1]
		margins.z = PRESET_DEFINITIONS.get(_preset)[2]
		margins.w = PRESET_DEFINITIONS.get(_preset)[3]
	_update_margins()


func _remove_overrides() -> void:
	remove_theme_color_override("margin_left")
	remove_theme_constant_override("margin_top")
	remove_theme_constant_override("margin_right")
	remove_theme_constant_override("margin_bottom")
