extends ColorRect

@export var upload_options : OptionButton
@export var piracy_anim_player : AnimationPlayer
@export var message : Label
func _on_upload_button_item_selected(index):
	if index == 0:
		message.text = "Uploading..."
		piracy_anim_player.play("upload_cyberattack")
		await piracy_anim_player.animation_finished
		SignalBus.ransomware_uploaded.emit()
		CyberattackManager.delivery_finished = true
	elif index == 1:
		message.text = "Uploading..."
		piracy_anim_player.play("upload_cyberattack")
		await piracy_anim_player.animation_finished
		SignalBus.fileless_uploaded.emit()
		CyberattackManager.delivery_finished = true


func _on_upload_button_pressed():
	if CyberattackManager.ransomware_ready == false:
		upload_options.set_item_disabled(0, true)
	elif CyberattackManager.ransomware_ready == true:
		upload_options.set_item_disabled(0, false)
	
	if CyberattackManager.fileless_ready == false:
		upload_options.set_item_disabled(1, true)
	elif CyberattackManager.fileless_ready == true:
		upload_options.set_item_disabled(1, false)
		
