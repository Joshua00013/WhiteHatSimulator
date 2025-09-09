extends MarginContainer

@onready var code_edit: CodeEdit = $CodeEdit
@onready var overlay: ColorRect = $Overlay
@onready var rich_text_label: RichTextLabel = $HFlowContainer/RichTextLabel


var step: int = 0

func _ready() -> void:
	rich_text_label.text = "This program works like a simple file locker: it looks for files in a folder, skips a few special ones, and then asks the user for a password. If the password matches the one set inside the code (“WhiteHaT”), it uses a secret key stored in 'key.key' to unlock (decrypt) all the files and restore them to their original form. If the password is wrong, it refuses to unlock anything and shows a warning message instead, similar to how ransomware works"
	
	rich_text_label.add_theme_font_size_override("normal_font_size", 24)
	overlay.visible = false
	step = 1

func _on_back_button_down() -> void:
	# TODO: Set limits on back and next
	if step > 0:
		step -= 1
		
		if step == 4:
			code_edit.scroll_vertical -= 10
		elif step == 6:
			code_edit.scroll_vertical -= 5
		set_step(step)
		

func _on_next_button_down() -> void:
	step += 1
	if step == 5:
		code_edit.scroll_vertical += 10
	elif step == 7:
		code_edit.scroll_vertical += 5
	
	set_step(step)
	
func _update_shader(pos:Vector2, size: Vector2) ->void:
	if overlay.material is ShaderMaterial:
		var shader_mat := overlay.material as ShaderMaterial
		shader_mat.set_shader_parameter("hole_position", pos)
		shader_mat.set_shader_parameter("hole_size", size)


func set_step(step: int) -> void:
	
	match step:
		1:
			overlay.visible = false
			rich_text_label.text = "This program works like a simple file locker: it looks for files in a folder, skips a few special ones, and then asks the user for a password. If the password matches the one set inside the code (“WhiteHaT”), it uses a secret key stored in 'key.key' to unlock (decrypt) all the files and restore them to their original form. If the password is wrong, it refuses to unlock anything and shows a warning message instead, similar to how ransomware works."
		2:
			overlay.visible = true
			rich_text_label.text = "The program uses os to interact with files and folders on your computer and imports Fernet from the cryptography library, a standard method for encrypting and decrypting bytes with a shared key."
			_update_shader(Vector2(0.115, 0.12), Vector2(3.495, 0.65))
		3:
			rich_text_label.text = "It looks at every item in the current folder, skips three special files which are the script itself (malware), the key file (key.key), and a decrypter script (decry), and if the item is an actual file (not a folder), adds it to allfiles."
			_update_shader(Vector2(0.115, 1.3), Vector2(3.495, 1.9))
		4:
			rich_text_label.text = "This shows what will be processed by printing the list so you can see which files are about to be touched."
			_update_shader(Vector2(0.115, 3.7), Vector2(3.495, 0.32))
		5:
			rich_text_label.text = "It loads the secret key from disk by opening key.key in binary mode and reading its bytes, which are the Fernet key used to decrypt the data"
			_update_shader(Vector2(0.115, 0.5), Vector2(3.495, 0.7))
		6:
			rich_text_label.text = "It sets a required passphrase, stored in passphrase, and uses input(...) to ask the user to type it, serving as a human check before performing any decryption."
			_update_shader(Vector2(0.115, 1.3), Vector2(3.495, 0.8))
		7:
			rich_text_label.text = "It only continues if the passphrase matches; if the user typed the correct passphrase, it proceeds, otherwise it stops and shows a “wrong password” message."
			_update_shader(Vector2(0.115, 0.10), Vector2(3.495, 4))
		8:
			rich_text_label.text = "It decrypts each file in allfiles by opening it to read all bytes, using the Fernet key (previously read from key.key) to decrypt those bytes, then opening the same file again for writing to overwrite it with the decrypted bytes and restore the original content, and finally printing a success message for each file."
			_update_shader(Vector2(0.115, 0.47), Vector2(3.495, 2.8))
