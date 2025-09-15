extends MarginContainer

@onready var code_edit: CodeEdit = $HSplitContainer/CodeEdit
@onready var overlay: ColorRect = $HSplitContainer/CodeEdit/Overlay
@onready var rich_text_label: RichTextLabel = $HSplitContainer/HFlowContainer/RichTextLabel

@export var back_button : Button
@export var animation : AnimationPlayer
@export var decryptor_window : Control
@export var _exit_button_decryptor_window : Button

var step: int = 0

signal ransomware_decrypt_finished

var ransomware_code = {
	"step_1" : "import os from\ncryptography.fernet import fernet",
	"step_2": "allfiles = []\nfor file in os.listdir():\n\tif file == malware or file == key.key or file == decry:\n\t\tcontinue\n\tif os.path.isfile(file):\n\t\tallfiles.append(file)\n\n",
	"step_3": "print(allfiles)\n\n",
	"step_4": "with open('key.key', 'rb') as key:\n\t\tpassword = key.read()\n",
	"step_5": "passphrase = 'WhiteHat'\nuserpass = input('Enter the password you received from us:')\n\n",
	"step_6": "if userpass == passphrase:\n\tfor file in allfiles:\n\t\twith open(file, \'rb\') as thefile:\n\t\t\t contents = thefile.read()\n\t\tcontent_decr = Fernet(password).decrypt(contents)\n\t\twith open(file, \"wb\") as thefile:\n \t\t\tthefile.write(content_decr)\n\t\tprint(\"You got your files back\')\nelse:\n \tprint('Wrong password! Pay to receive the right password')",
	
}
func _ready() -> void:
	back_button.disabled = true
	code_edit.text = ""
	overlay.visible = false 
	rich_text_label.text = "This code is a simple decryption program that scans through all files in the folder, skipping \"malware.py\", \"key.key\", and \"decr.py\". It asks the user for a password and checks if it matches a preset passphrase \"WhiteHat\". If the password is correct, it retrieves the actual encryption key from key.key, uses it with the Fernet library to decrypt each file’s contents, and restores them to their original state. If the password is wrong, the program refuses to decrypt and instead displays a message demanding payment, imitating the behavior of ransomware."
	

func _on_back_button_down() -> void:
	# TODO: Set limits on back and next
	if step > 0:
		step -= 1
		set_step(step)
		back_button.disabled = false
	if step == 0:
		set_step(step)
		back_button.disabled = true

func _on_next_button_down() -> void:
	back_button.disabled = false
	step += 1
	set_step(step)

func set_step(step: int) -> void:
	match step:
			#overlay.visible = false
			#code_edit.text =  ransomware_code.step_1
			#rich_text_label.text = "This program works like a simple file locker: it looks for files in a folder, skips a few special ones, and then asks the user for a password. If the password matches the one set inside the code (“WhiteHaT”), it uses a secret key stored in 'key.key' to unlock (decrypt) all the files and restore them to their original form. If the password is wrong, it refuses to unlock anything and shows a warning message instead, similar to how ransomware works."
		1:
			overlay.visible = true
			code_edit.text = ransomware_code.step_1
			rich_text_label.text = "step 1: Importing the Tools\n\nThis part is about imports. The \"os\" module is brought in so the program can look through files and directories, while \"cryptography.fernet\" (with Fernet) is imported to handle the actual encryption and decryption of file contents. In short, \"os\" manages the files, and Fernet provides the security tools."
			animation.play("decrypt_ransomware_step1.3")		
		2:
			code_edit.text = ransomware_code.step_1 + "\n\n" + ransomware_code.step_2 + ransomware_code.step_3
			rich_text_label.text = "step 2: Collecting Files to Encrypt\n\nOn this part of the code is just collecting the files that will later be decrypted. It looks at everything in the current folder, skips over \"malware.py\", \"key.key\", and \"decr.py\" (so they won’t be touched), and then checks if each item is actually a file, not a folder. All valid files get added to the allfiles[] list, which is then printed so you can see which files are included."
			animation.play("decrypt_ransomware_step3")			
		3:
			code_edit.text = ransomware_code.step_1 + "\n\n" + ransomware_code.step_2  + ransomware_code.step_3 + ransomware_code.step_4
			rich_text_label.text = "step 3: Loadi the \"Password key\"\n\nThe program opens the file named \"key.key\" in binary mode and reads its contents. Those contents are actually the secret Fernet key, and that’s what the program needs in order to unlock, or decrypt, the data."
			animation.play("decrypt_ransomware_step4")
		4:
			code_edit.text = ransomware_code.step_1 + "\n\n" + ransomware_code.step_2  + ransomware_code.step_3 + ransomware_code.step_4 + ransomware_code.step_5
			rich_text_label.text = "step 4: Ask for the Passphrase(Password)\n\n- Next, the program sets a password inside the code itself, called the passphrase \"WhiteHat\"."
			animation.play("decrypt_ransomware_step5")
		5:	
			code_edit.text = ransomware_code.step_1 + "\n\n" + ransomware_code.step_2  + ransomware_code.step_3 + ransomware_code.step_4 + ransomware_code.step_5
			rich_text_label.text = "step 4: Ask for the Passphrase(Password)\n\n- Next, the program sets a password inside the code itself, called the passphrase \"WhiteHat\".\n\n- Then, it asks the user to type the password they received.\n\nThis step is like a security guard at the door.Even if someone stole the real key \"key.key\", they still wouldn’t get inside unless they also knew the secret password."
			animation.play("decrypt_ransomware_step5.2")						
		6:
			code_edit.text = ransomware_code.step_1 + "\n\n" + ransomware_code.step_2  + ransomware_code.step_3 + ransomware_code.step_4 + ransomware_code.step_5 + ransomware_code.step_6
			rich_text_label.text = "step 5: Decrypt the Files\n\nIf the user types the correct passphrase, the decyption program begins the real work:\n\n"
			animation.play("decrypt_ransomware_step6")
		7:	
			rich_text_label.text = "step 5: Decrypt the Files\n\nIf the user types the correct passphrase, the decyption program begins the real work:\n\n- It opens each encrypted file and reads the scrambled data inside."
			animation.play("decrypt_ransomware_step6.2")
		8:	
			rich_text_label.text = "step 5: Decrypt the Files\n\nIf the user types the correct passphrase, the decyption program begins the real work:\n\n- It opens each encrypted file and reads the scrambled data inside.\n\n- It uses the Fernet key to decrypt (or “unscramble”) that data."
			animation.play("decrypt_ransomware_step6.3")
		9:	
			rich_text_label.text = "step 5: Decrypt the Files\n\nIf the user types the correct passphrase, the decyption program begins the real work:\n\n- It opens each encrypted file and reads the scrambled data inside.\n\n- It uses the Fernet key to decrypt (or “unscramble”) that data.\n\n- It opens the same file again, but this time in write mode, and replaces the scrambled content with the original, readable version."
			animation.play("decrypt_ransomware_step6.4")
		10:	
			code_edit.text = ransomware_code.step_1 + "\n\n" + ransomware_code.step_2  + ransomware_code.step_3 + ransomware_code.step_4 + ransomware_code.step_5 + ransomware_code.step_6
			rich_text_label.text = "step 5: Decrypt the Files\n\n- Finally, it tells the user: “You got your files back.” \n\nAt this point, the files are restored, just like they were before being locked."
			animation.play("decrypt_ransomware_step6.5")
		11:
			rich_text_label.text = "step 6 : Handle Wrong Passwords\n\n- If the user types the wrong passphrase, the program refuses to continue.\n\nThe files stay locked, and the script shows a threatening message that mimics how real ransomware works: it tells you to pay money to get the right password."
			animation.play("decrypt_ransomware_step7")
		12:
			decryptor_window.visible = true
			#_exit_button_decryptor_window.disabled=true
			
			
func _on_password_check_component_correct_password() -> void:
	CyberattackManager.ransomware_ready = true
	ransomware_decrypt_finished.emit()
