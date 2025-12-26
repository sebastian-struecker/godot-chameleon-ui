@tool
class_name FontSizeGCUI
extends RefCounted


static func font_size(control: Control, size: int) -> void:
	if !control:
		return
	control.remove_theme_font_size_override("font_size")
	control.add_theme_font_size_override("font_size", size)
