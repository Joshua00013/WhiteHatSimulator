extends ColorRect

@onready var hosting_player: AnimationPlayer = $HostingPlayer
@onready var window_2: PanelContainer = $Window2

func _ready() -> void:
	window_2.visible = false
	
func _on_button_pressed() -> void:
	hosting_player.play("hosting_uploading")
	await hosting_player.animation_finished
	CyberattackManager.phishing_site_hosted = true

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("next_pressed"):
		SignalBus.phishing_site_hosted.emit()


func _on_submit_button_pressed() -> void:
	SignalBus.phishing_site_hosted.emit()
