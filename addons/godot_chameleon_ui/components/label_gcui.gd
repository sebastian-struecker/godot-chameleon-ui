@tool
class_name LabelGCUI
extends Label

const BASE_TYPE: ChameleonUI.BASE_TYPE = ChameleonUI.BASE_TYPE.LABEL

const FontSizeGcui = preload("../utilities/font_size_gcui.gd")
const FontShadowGcui = preload("../utilities/font_shadow_gcui.gd")
const FontOutlineGcui = preload("../utilities/font_outline_gcui.gd")

@export var control_theme: Theme:
	set(value):
		control_theme = value
		theme = value
		_update_from_theme(value)
@export_range(0, 999, 1) var font_size: int = 16:
	set(value):
		font_size = value
		if theme:
			return
		FontSizeGcui.font_size(self, value)
@export var shadow: FontShadowGCUI.PRESET = FontShadowGCUI.PRESET.NONE:
	set(value):
		shadow = value
		if theme:
			return
		FontShadowGcui.preset(self, shadow_color, value)
@export var shadow_color: Color = Color.BLACK:
	set(value):
		shadow_color = value
		if theme:
			return
		FontShadowGcui.preset(self, value, shadow)
@export var outline: FontOutlineGCUI.PRESET = FontOutlineGCUI.PRESET.NONE:
	set(value):
		outline = value
		if theme:
			return
		FontOutlineGcui.preset(self, outline_color, value)
@export var outline_color: Color = Color.BLACK:
	set(value):
		outline_color = value
		if theme:
			return
		FontOutlineGcui.preset(self, value, outline)


func _update_from_theme(_theme: Theme) -> void:
	if _theme:
		font_size = ThemeUtilsGCUI.get_font_size(_theme, BASE_TYPE)
		shadow = FontShadowGCUI.PRESET.FROM_THEME
		shadow_color = ThemeUtilsGCUI.get_font_shadow_color(_theme, BASE_TYPE)
		outline = FontOutlineGCUI.PRESET.FROM_THEME
		outline_color = ThemeUtilsGCUI.get_font_outline_color(_theme, BASE_TYPE)
	else:
		font_size = 16
		shadow = FontShadowGCUI.PRESET.NONE
		shadow_color = Color.BLACK
		outline = FontOutlineGCUI.PRESET.NONE
		outline_color = Color.BLACK
