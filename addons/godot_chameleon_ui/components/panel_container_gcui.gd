@tool
class_name PanelContainerGCUI
extends PanelContainer

const BASE_TYPE: ChameleonUI.BASE_TYPE = ChameleonUI.BASE_TYPE.PANEL_CONTAINER
const TransparencyMaterialGcui = preload("../utilities/transparency_material_gcui/transparency_material_gcui.gd")

@export var control_theme: Theme:
	set(value):
		control_theme = value
		theme = value
@export_range(0, 1, 0.01) var transparency: float = 1.0:
	set(value):
		transparency = value
		TransparencyMaterialGcui.transparency(self, value)
