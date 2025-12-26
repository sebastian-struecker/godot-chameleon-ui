@tool
extends EditorPlugin


func _enable_plugin() -> void:
	add_autoload_singleton("ChameleonUI", "res://addons/godot_chameleon_ui/chameleon_ui.gd")


func _disable_plugin() -> void:
	remove_autoload_singleton("ChameleonUI")


func _enter_tree() -> void:
	pass


func _exit_tree() -> void:
	pass
