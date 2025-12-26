extends Node

enum BASE_TYPE {
	BUTTON,
	CHECK_BOX,
	DROPDOWN,
	LABEL,
	PANEL_CONTAINER,
}

const base_types: Dictionary[BASE_TYPE, String] = {
	BASE_TYPE.BUTTON: "Button",
	BASE_TYPE.CHECK_BOX: "CheckBox",
	BASE_TYPE.DROPDOWN: "OptionButton",
	BASE_TYPE.LABEL: "Label",
	BASE_TYPE.PANEL_CONTAINER: "PanelContainer"
}
