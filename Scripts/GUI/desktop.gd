extends Control

@export var radial_menu : Control
@export var cyberattack_lbl : Label
@export var ransomware_recon_done := false
signal ransomware_start

func _ready() -> void:
	var viewport_center: Vector2 = get_viewport_rect().size / 2
	if ransomware_recon_done && radial_menu!= null:
		radial_menu.open_menu(viewport_center)


func _on_radial_menu_item_hovered(item: Variant) -> void:
	cyberattack_lbl.text = item.title


func _on_radial_menu_item_selected(id: Variant, position: Variant) -> void:
	match id:
		"cyberattack_1":
			ransomware_start.emit()
