class_name ThemeUtilsGCUI
extends Node


static func get_font_size(theme: Theme, type: ChameleonUI.BASE_TYPE) -> int:
	var font_size: int = theme.get_font_size("font_size", _base_type_name(type))
	return font_size


static func get_font_shadow_color(theme: Theme, type: ChameleonUI.BASE_TYPE) -> Color:
	var font_shadow_color: Color = theme.get_color("font_shadow_color", _base_type_name(type))
	return font_shadow_color


static func get_font_outline_color(theme: Theme, type: ChameleonUI.BASE_TYPE) -> Color:
	var font_outline_color: Color = theme.get_color("font_outline_color", _base_type_name(type))
	return font_outline_color


static func _base_type_name(type: ChameleonUI.BASE_TYPE, default: String = "") -> String:
	return ChameleonUI.base_types.get(type, default)
