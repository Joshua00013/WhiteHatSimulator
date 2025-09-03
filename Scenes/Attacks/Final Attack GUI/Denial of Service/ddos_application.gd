extends MarginContainer

@onready var overlay: ColorRect = $HSplitContainer/CodeEdit/Overlay
@onready var rich_text_label: RichTextLabel = $HSplitContainer/HFlowContainer/RichTextLabel
@onready var inv : Inv = preload("res://Items/player_inventory.tres")
@onready var url_text: RichTextLabel = $"HSplitContainer/CodeEdit/DOS_APPLICATION/Body/url & ip/url bar/url text"
@export var animation:AnimationPlayer

var step: int = 0

func _ready() -> void:
	animation.play("ddos_start")
	
func _on_back_button_down() -> void:
	# TODO: Set limits on back and next
	if step >= 1:
		step -= 1
		set_step(step)
		
func _on_next_button_down() -> void:
	step += 1
	set_step(step)

		
func set_step(step: int) -> void:
	match step:
		#Stsrt or MSFVENOM Start
		1:
			rich_text_label.text = "First lets type in the URL of the companies' website"
			animation.play("ddos_1")
		2: 
			rich_text_label.text = "Lock it in so we can find the IP address"
			animation.play("ddos_2")
		3:
			rich_text_label.text = "There it is, now type it in the text box and lock it in"
			animation.play("ddos_3")
			
		4:
			rich_text_label.text = "Now this are other options to modify our DDOS attack"
			animation.play("ddos_4")
		5:
			rich_text_label.text = "Timeout is how long LOIC waits before giving up on a single connection or request"
			animation.play("ddos_5")
		6:
			rich_text_label.text = "Now in HTTP Subsite, it specifies which page or file we will target and will request rapidly"
			animation.play("ddos_6")
		7:
			rich_text_label.text = "In TCP/UDP Message, it lets you put custom data or message inside the packets that will be sent"
			animation.play("ddos_7")
		8:
			rich_text_label.text = "Now this is where we determine which service are we attacking, the default is 80"
			animation.play("ddos_8")
		9:
			rich_text_label.text = "This determine which method are we choosing from TCP, UDP, HTTP"
			animation.play("ddos_9")
		10:
			rich_text_label.text = "Now for the threads, this is the number of simultaneous attack \n\n More Threads, More traffic"
			animation.play("ddos_10")
		11:
			rich_text_label.text = "Now this just checks for a reply"
			animation.play("ddos_11")
		12:
			rich_text_label.text = "Now this throttle is the delay between packets \n\n Higher speed, less delay \n Lower speed, more delay"
			animation.play("ddos_12")
		13:
			rich_text_label.text = "All done lets now check if it is working"
		14:
			animation.play("ddos_result")
