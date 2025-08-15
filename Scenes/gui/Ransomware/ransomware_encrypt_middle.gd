extends Control

@onready var companyfile_text: Label = $computerWindowsAssets/companyfileText
@onready var myfile_text: Label = $computerWindowsAssets/myfileText
@onready var image: Label = $computerWindowsAssets/image

@onready var pdf_button: Button = $Buttons/pdfButton
@onready var malware_button: Button = $Buttons/malwareButton
@onready var company_button: Button = $Buttons/companyButton
@onready var godot_button: Button = $Buttons/godotButton

@onready var computer_windows_template: Control = $computerWindowsTemplate

func _on_pdf_button_pressed() -> void:
	computer_windows_template.visible = true
	myfile_text.visible = true
	
	godot_button.flat = false
	company_button.flat = false
	malware_button.flat = false
	
	godot_button.disabled = true
	company_button.disabled = true
	malware_button.disabled = true

	
func _on_exit_button_pressed() -> void:
	companyfile_text.visible = false
	myfile_text.visible = false
	image.visible = false
	computer_windows_template.visible = false
	
	
	pdf_button.flat = false
	godot_button.flat = false
	company_button.flat = false
	
	
	pdf_button.disabled = false
	godot_button.disabled = false
	company_button.disabled = false
	malware_button.disabled = false


func _on_godot_button_pressed() -> void:
	computer_windows_template.visible = true
	image.visible = true
	
	pdf_button.flat = true
	company_button.flat = true
	malware_button.flat = true
	
	pdf_button.disabled = true
	company_button.disabled = true
	malware_button.disabled = true


func _on_company_button_pressed() -> void:
	computer_windows_template.visible = true
	companyfile_text.visible = true
	
	pdf_button.flat = true
	godot_button.flat = true
	malware_button.flat = true

	pdf_button.disabled = true
	godot_button.disabled = true
	malware_button.disabled = true


func _on_malware_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/gui/Ransomware/ransomwareEncrypt_Part1.tscn")
