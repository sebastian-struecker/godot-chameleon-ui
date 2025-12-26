@tool
class_name SeparationGCUI
extends RefCounted


static func separation(control: Control, separation: int) -> void:
	if !control:
		return
	if control is BoxContainer:
		control.remove_theme_constant_override("separation")
		control.add_theme_constant_override("separation", separation)
	elif control is Label:
		control.remove_theme_font_size_override("separation")
		control.add_theme_font_size_override("separation", separation)
	elif control is BaseButton:
		control.remove_theme_constant_override("h_separation")
		control.add_theme_constant_override("h_separation", separation)
