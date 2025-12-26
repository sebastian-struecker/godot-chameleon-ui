@tool
class_name TextureRectGCUI
extends TextureRect

const TransparencyMaterialGcui = preload("../utilities/transparency_material_gcui/transparency_material_gcui.gd")

@export var custom_texture: Texture:
	set(value):
		custom_texture = value
		if value != null:
			texture = value
			texture_size = texture.get_size()
		else:
			texture = null
			texture_size = Vector2(64, 64)
@export var texture_size: Vector2 = Vector2(64, 64):
	set(value):
		texture_size = value
		call_deferred("_set_correct_size")
@export_range(0, 1, 0.01) var transparency: float = 1.0:
	set(value):
		transparency = value
		TransparencyMaterialGcui.transparency(self, value)


func _set_correct_size() -> void:
	custom_minimum_size = texture_size
	set_deferred("size", texture_size)
