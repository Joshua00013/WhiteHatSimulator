extends MarginContainer

@onready var code_edit: CodeEdit = $HSplitContainer/CodeEdit
@onready var overlay: ColorRect = $HSplitContainer/CodeEdit/Overlay
@onready var rich_text_label: RichTextLabel = $HSplitContainer/HFlowContainer/RichTextLabel

@export var back_button : Button
@export var animation : AnimationPlayer
@export var decryptor_window : Control
@export var _exit_button_decryptor_window : Button

var step: int = 0
var ransomware_code = {
	"step_1" : "import os from cryptography.fernet\nimport fernet",
	"step_2": "allfiles = []\nfor file in os.listdir():\n\tif file == malware or file == key.key or file == decry:\n\t\tcontinue\n\tif os.path.isfile(file):\n\t\tallfiles.append(file)\n\n",
	"step_3": "print(allfiles)\n\n",
	"step_4": "with open('key.key', 'rb') as key:\n\t\tpassword = key.read()\n",
	"step_5": "passphrase = 'WhiteHaT'\nuserpass = input('Enter the password you received from us:')\n\n",
	"step_6": "if userpass == passphrase:\n\tfor file in allfiles:\n\t\twith open(file, \'rb\') as thefile:\n\t\t\t contents = thefile.read()\n\t\tcontent_decr = Fernet(password).decrypt(contents)\n\t\twith open(file, \"wb\") as thefile:\n \t\t\tthefile.write(content_decr)\n\t\tprint(\"You got your files back\')\nelse:\n \tprint('Wrong password! Pay to receive the right password')",
	
}
func _ready() -> void:
	back_button.disabled = true
	code_edit.text = ""
	overlay.visible = false 
	rich_text_label.text = "This program works like a simple file locker: it looks for files in a folder, skips a few special ones, and then asks the user for a password. If the password matches the one set inside the code (“WhiteHaT”), it uses a secret key stored in 'key.key' to unlock (decrypt) all the files and restore them to their original form. If the password is wrong, it refuses to unlock anything and shows a warning message instead, similar to how ransomware works."
	

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
			rich_text_label.text = "The program uses os to interact with files and folders on your computer and imports Fernet from the cryptography library, a standard method for encrypting and decrypting bytes with a shared key."
			animation.play("decrypt_ransomware_step1")
		2:
			code_edit.text = ransomware_code.step_1 + "\n\n" + ransomware_code.step_2
			rich_text_label.text = "It looks at every item in the current folder, skips three special files which are the script itself (malware), the key file (key.key), and a decrypter script (decry), and if the item is an actual file (not a folder), adds it to allfiles."
			animation.play("decrypt_ransomware_step2")
		3:
			code_edit.text = ransomware_code.step_1 + "\n\n" + ransomware_code.step_2 + ransomware_code.step_3
			rich_text_label.text = "This shows what will be processed by printing the list so you can see which files are about to be touched."
			animation.play("decrypt_ransomware_step3")
		4:
			code_edit.text = ransomware_code.step_1 + "\n\n" + ransomware_code.step_2  + ransomware_code.step_3 + ransomware_code.step_4
			rich_text_label.text = "It loads the secret key from disk by opening key.key in binary mode and reading its bytes, which are the Fernet key used to decrypt the data"
			animation.play("decrypt_ransomware_step4")
		5:
			code_edit.text = ransomware_code.step_1 + "\n\n" + ransomware_code.step_2  + ransomware_code.step_3 + ransomware_code.step_4 + ransomware_code.step_5
			rich_text_label.text = "It sets a required passphrase, stored in passphrase, and uses input(...) to ask the user to type it, serving as a human check before performing any decryption."
			animation.play("decrypt_ransomware_step5")
		6:
			code_edit.text = ransomware_code.step_1 + "\n\n" + ransomware_code.step_2  + ransomware_code.step_3 + ransomware_code.step_4 + ransomware_code.step_5 + ransomware_code.step_6
			rich_text_label.text = "It only continues if the passphrase matches; if the user typed the correct passphrase, it proceeds, otherwise it stops and shows a “wrong password” message."
			animation.play("decrypt_ransomware_step6")
		7:
			rich_text_label.text = "It decrypts each file in allfiles by opening it to read all bytes, using the Fernet key (previously read from key.key) to decrypt those bytes, then opening the same file again for writing to overwrite it with the decrypted bytes and restore the original content, and finally printing a success message for each file."
			animation.play("decrypt_ransomware_step7")
		8:
			decryptor_window.visible = true
			#_exit_button_decryptor_window.disabled=true
			
			
			
