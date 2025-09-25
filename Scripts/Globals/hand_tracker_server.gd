extends Node

var tcpserver = TCPServer.new()
var client: StreamPeerTCP = null
var port := 12345 #Change depending on python program

@export var state: bool = false
func _ready():
	if state == true:
		start_server()

func start_server():
	var result = tcpserver.listen(port)
	if result == OK:
		print ("TCP server started on port %d" %port)
	else:
		print("Failed to start server")
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if tcpserver.is_connection_available() and client == null:
		client = tcpserver.take_connection()
		print("Client connected")
	if client != null and client.get_available_bytes() > 0:
		var available_bytes = client.get_available_bytes()
		var result = client.get_data(available_bytes)  # Receive data and error code
		var err_code = result[0]  # Error code
		var data = result[1]  # Data
		if err_code == OK:
			var decoded_data = data.get_string_from_utf8()  # Convert the byte array to a string
			handle_input(decoded_data)
		else:
			print("Error receiving data:", err_code)
			
var action_map := {
	"release": func(): 
		Input.action_release("hold"),
	"hold": func():
		Input.action_press("hold")
}

func handle_input(data: String):
	print("Received:", data)
	if action_map.has(data):
		action_map[data].call()

func resume_server():
	if client != null:
		send_to_python("resume")

func pause_server():
	if client != null:
		pass
		#send_to_python("pause")

func stop_server():
	if client != null:
		send_to_python("exit")
		await get_tree().process_frame
		client.disconnect_from_host()
		client = null
	if tcpserver.is_listening():
		tcpserver.stop()
		print("TCP server stopped")

func send_to_python(message: String):
	if client != null:
		client.put_utf8_string(message)
		print("Sent to Python:", message)

func _exit_tree():
	stop_server()
