extends MarginContainer

var encrypted := false
@export var shader: ColorRect
@export var cards_container: ScrollContainer

@export var malware_icon : VBoxContainer
@export var decr_icon : VBoxContainer
@export var key_icon : VBoxContainer
@export var loic_icon : VBoxContainer

@onready var animation_player = $AnimationPlayer

func _ready():
	malware_icon.hide()
	decr_icon.hide()
	key_icon.hide()
	loic_icon.hide()
	CyberattackManager.cyberattack_ready.connect(_on_cyberattack_ready)

func _ransomware_pressed():
	SignalBus.cyberattack_selected.emit("Ransomware")
	
func _bruteforce_pressed():
	SignalBus.cyberattack_selected.emit("Bruteforce")
	
func _phishing_pressed():
	SignalBus.cyberattack_selected.emit("Phishing")
	
func _fileless_pressed():
	SignalBus.cyberattack_selected.emit("Fileless")
	
func _dos_pressed():
	SignalBus.cyberattack_selected.emit("DOS")

func hide_cards():
	shader.hide()
	cards_container.hide()
	
func show_cards():
	shader.show()
	cards_container.show()

func _on_cyberattack_ready(cyberattack):
	if cyberattack == "ransomware":
		malware_icon.show()
		decr_icon.show()
		key_icon.show()
	if cyberattack == "dos":
		loic_icon.show()


func _on_loic_icon_pressed():
	pass # Replace with function body.
