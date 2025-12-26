@tool
class_name ThemeValidationGCUI
extends RefCounted

@export var theme_required: bool = false
@export var expected_variations: Array[String] = []
@export var expected_icons: Array[String] = []


static func validate_theme(theme: Theme, requirements: ThemeRequirements, base_type: ChameleonUI.BASE_TYPE) -> Array[String]:
	var warnings: Array[String] = []
	if requirements.theme_required && theme == null:
		warnings.append("Theme is missing")
	if base_type == null:
		warnings.append("Base type is missing")
	if theme == null || base_type == null:
		return warnings
	warnings.append_array(_validate_base_type(theme, requirements, base_type))
	warnings.append_array(_validate_variations(theme, requirements, base_type))
	warnings.append_array(_validate_icons(theme, requirements, base_type))
	return warnings


static func _validate_base_type(theme: Theme, requirements: ThemeRequirements, base_type: ChameleonUI.BASE_TYPE) -> Array[String]:
	var warnings: Array[String] = []
	var base_type_name: String = ChameleonUI.base_types.get(base_type, "")
	var type_list = theme.get_type_list()
	if !type_list.has(base_type_name):
		warnings.append(str("Theme is missing a base type for: ", base_type_name))
	return warnings


static func _validate_variations(theme: Theme, requirements: ThemeRequirements, base_type: ChameleonUI.BASE_TYPE) -> Array[String]:
	var warnings: Array[String] = []
	var base_type_name: String = ChameleonUI.base_types.get(base_type, "")
	var existing_variations = theme.get_type_variation_list(base_type_name)
	for v in requirements.expected_variations:
		if !existing_variations.has(v):
			warnings.append(str("Theme is missing a variation for: ", base_type_name))
	return warnings


static func _validate_icons(theme: Theme, requirements: ThemeRequirements, base_type: ChameleonUI.BASE_TYPE) -> Array[String]:
	var warnings: Array[String] = []
	if theme:
		var base_type_name: String = ChameleonUI.base_types.get(base_type, "")
		for i in requirements.expected_icons:
			if !theme.has_icon(i, base_type_name):
				warnings.append(str("Theme is missing an icon for: ", i))
	return warnings
