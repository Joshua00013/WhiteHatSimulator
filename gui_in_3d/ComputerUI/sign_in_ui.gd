extends Control


func _on_signin_pressed():
	get_tree().change_scene_to_file("res://gui_in_3d/ComputerUI/computer_ui.tscn")
# Mali to, pakabit diretsyo sa component yung scene ng computer UI, wag local directory. Each instance should own their GUI.
# And yung handling ng signal, sa parent node dapat which is computer. Hindi sa component. Hindi dapat maging dependent sa 
# script ng component ang parent. Ireference mo yung UI component and sign in component sa parent nila and dun ihandle ang events.
# Use custom signals if necessary.
