extends PanelContainer

func _ready() -> void:
	ConfigFileHandler.apply_display_mode()

func _on_animation_player_animation_finished(_anim_name: StringName) -> void:
	SceneTransition.fade_in()
	get_tree().change_scene_to_file("res://GUI/MainMenuUI/main_menu.tscn")
