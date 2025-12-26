class_name ThemeRequirements
extends RefCounted

@export var theme_required: bool = false
@export var expected_variations: Array[String] = []
@export var expected_icons: Array[String] = []


func _init(_theme_required: bool, _expected_variations: Array[String], _expected_icons: Array[String]) -> void:
	theme_required = _theme_required
	expected_variations = _expected_variations
	expected_icons = _expected_icons
