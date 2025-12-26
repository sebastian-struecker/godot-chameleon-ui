@tool
class_name BoxContainerGCUI
extends BoxContainer

enum TYPE {
	HORIZONTAL,
	VERTICAL,
}

const SeparationGcui = preload("../utilities/separation_gcui.gd")

@export var type: TYPE = TYPE.HORIZONTAL:
	set(value):
		type = value
		match type:
			TYPE.HORIZONTAL:
				vertical = false
			TYPE.VERTICAL:
				vertical = true
@export var separation: int = 8:
	set(value):
		separation = value
		SeparationGcui.separation(self, value)
