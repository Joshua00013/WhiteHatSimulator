extends TabContainer

@export var malware_icon := VBoxContainer
@export var decr_icon := VBoxContainer
@export var key_icon := VBoxContainer

func _on_window_container_ransomware_start() -> void:
	current_tab = 1


func _on_ransomware_window_window_exited() -> void:
	current_tab = 2


func _on_button_button_down() -> void:
	current_tab = 3


func finish_button_down() -> void:
	current_tab = 0
	malware_icon.visible = true
	decr_icon.visible = true
	key_icon.visible = true
