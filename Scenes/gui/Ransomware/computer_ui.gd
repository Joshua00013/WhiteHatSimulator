extends MarginContainer


@onready var windowsUI_image_panel: Panel = $windowsUI/VBoxContainer/Body/MarginContainer2/ImagePanel
@export var windows_ui: Control
@export var windowsUI_body_label : Control
#@onready var computer_gui: TabContainer = $"."

func _on_pdf_button_pressed() -> void:
	windowsUI_image_panel.visible = false
	windows_ui.visible = true
	windowsUI_body_label.visible = true
	windowsUI_body_label.text = "This file has your personal and sensitive data such as:
		-> Full name
		-> Address
		-> Mobile Numbers
		-> Bank Informations"


func _on_image_button_pressed() -> void:
	windowsUI_body_label.visible = false
	windows_ui.visible = true
	windowsUI_image_panel.visible = true
	


func _on_companyfile_button_pressed() -> void:
	windowsUI_image_panel.visible = false
	windows_ui.visible = true
	windowsUI_body_label.visible = true
	windowsUI_body_label.text = "This file contains sensitive data of clients such as:
		-> Full name
		-> Address
		-> Mobile Numbers
		-> Bank Informations"
