extends MarginContainer

@onready var overlay: ColorRect = $Overlay
@onready var code_edit: CodeEdit = $CodeEdit

@onready var rich_text_label: RichTextLabel = $HFlowContainer/RichTextLabel
@onready var computer_gui: TabContainer = $".."


var step: int = 0
var computerUI = "res://GUI/ComputerUI/pc_gui_macky.gd"


func _ready() -> void:
	rich_text_label.text = "This code demonstrates the logic of how malware infects a system. Let's explore and understand, line by line, how this code works."
	
	#font sizeng description
	rich_text_label.add_theme_font_size_override("normal_font_size", 25)
	overlay.visible = false
	step = 1	
	

func _on_back_button_down() -> void:
	# TODO: Set limits on back and next
	if step > 0:
		step -= 1
		
		if step == 8:
			code_edit.scroll_vertical -= 5
		elif step == 11:
			code_edit.scroll_vertical -= 9
		set_step(step)

func _on_next_button_down() -> void:
	step += 1
	if step == 9:
		code_edit.scroll_vertical += 5
	elif  step == 12:
		code_edit.scroll_vertical += 9
	set_step(step)
	
func _update_shader(pos:Vector2, size: Vector2) ->void:
	if overlay.material is ShaderMaterial:
		var shader_mat := overlay.material as ShaderMaterial
		shader_mat.set_shader_parameter("hole_position", pos)
		shader_mat.set_shader_parameter("hole_size", size)



@onready var ComputerUI: PackedScene = preload("res://Scenes/gui/Ransomware/ComputerUI.tscn")
func set_step(step: int) -> void:
	if step == 15:
		#computer_gui.current_tab = 0
		step = 15
		
		var newComputerUI = ComputerUI.instantiate()
		add_child(newComputerUI)
		
		#Check if the instantiation is successful
		#if newComputerUI != null:
		#	print("NOT null")
		
		newComputerUI.get_node("Margin/Desktop/pdfIcon/Button")
		
		
	match step:
		1:
			rich_text_label.text = "This code demonstrates the logic of how malware infects a system. Let's explore and understand, line by line, how this code works."
			overlay.visible = false
			step = 1
		2: 	
			rich_text_label.text = "Stage 1: Importing Required Modules We need to bring in the modules to handle files and encryption."
			overlay.visible = true
			_update_shader(Vector2(0.115, 0.12), Vector2(3.495, 0.67))
		3: 	
			rich_text_label.text = "The os is a python’s built-in library for interacting with the file system. It allows you to list files, check if something is a file, etc."
			_update_shader(Vector2(0.115, 0.12), Vector2(3.495, 0.298))
		4: 	
			rich_text_label.text = "It imports the Fernet class from the cryptography library, which provides strong and secure encryption and decryption functions."
			_update_shader(Vector2(0.115, 0.46), Vector2(3.495, 0.34))
		5: 	
			rich_text_label.text = "Creates an empty list to store the names of the files we want to encrypt."
			_update_shader(Vector2(0.115, 1.27), Vector2(3.495, 0.34))
		6: 	
			rich_text_label.text = "Stage 2: Collecting Target Files
The program loops through all entries in the current directory (the folder where the script runs), selecting files to encrypt while avoiding itself, the encryption key file, and any decryption program"
			_update_shader(Vector2(0.115, 1.37), Vector2(3.495, 1.35))
		7: 	
			rich_text_label.text = "Skips certain files:
malware —> the script itself (so it doesn’t self-encrypt). \n
key.key —> the key file we will generate. \n 
decr —> likely a decryption script. \n
continue tells the loop to skip to the next item."
			_update_shader(Vector2(0.115, 1.50), Vector2(3.495, 0.50))
		8: 	

			rich_text_label.text = "It checks if the current item is a regular file (not a folder), and if so, adds it to the allfiles list and prints the list of files to be encrypted, mainly for checking or demonstration purposes."
			_update_shader(Vector2(0.115, 2.80), Vector2(3.495, 1.10))
			
		9: 	
			
			rich_text_label.text = "Stage 3: Generating and Saving the Encryption Key
The program creates a special secret key, like a password used to lock and unlock the files. It then saves that key into a file called key.key."
			_update_shader(Vector2(0.115, 2.42), Vector2(3.495, 1.13))
		10: 	
			rich_text_label.text = "It creates a new encryption key using Fernet’s built-in function, which will be required to decrypt the files later."
			_update_shader(Vector2(0.115, 2.48), Vector2(3.495, 0.37))
		11: 	
			
			rich_text_label.text = "It opens a file called key.key in write-binary mode, saves the generated encryption key inside, and acts like storing the “password” in a separate note to unlock the files later."
			_update_shader(Vector2(0.115, 2.90), Vector2(3.495, 0.73))			
		12: 	
			
			rich_text_label.text = "Stage 4: Encrypting the Files Each file in the list is opened, its content is read, encrypted with the key, and then written back in its scrambled (unreadable) form."
			_update_shader(Vector2(0.115, .45), Vector2(3.495, 2.33))
		13: 	
			rich_text_label.text = "It loops through all entries (files and folders) in the current directory, then goes through each file in allfiles, opens it in read-binary mode to load its contents, encrypts the data using Fernet(key).encrypt(content) to turn it into unreadable data, and finally opens the file again in write-binary mode to replace the original content with the encrypted version, making the readable data inaccessible unless decrypted with the same key."
			_update_shader(Vector2(0.115, .45), Vector2(3.495, 2.33))
		14: 	
			rich_text_label.text = "Finally, the program prints a message letting you know that all the files have been encrypted."
			_update_shader(Vector2(0.115, 3.3), Vector2(3.495, 0.30))


	
		

		
			
			
			
