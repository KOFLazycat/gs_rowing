class_name WebsocketClient
extends Node

@export var button: Button
@export var label: Label
## The URL we will connect to.
@export var websocket_url: StringName = "ws://localhost:9080"


var socket := WebSocketPeer.new()

func log_message(message: String) -> void:
	var time := Time.get_time_string_from_system()
	label.text = time + message + "\n"


func _ready() -> void:
	button.pressed.connect(_on_button_pressed)
	
	if socket.connect_to_url(websocket_url) != OK:
		log_message("Unable to connect.")
		set_process(false)


func _process(_delta: float) -> void:
	socket.poll()

	if socket.get_ready_state() == WebSocketPeer.STATE_OPEN:
		while socket.get_available_packet_count():
			log_message(socket.get_packet().get_string_from_ascii())


func _exit_tree() -> void:
	socket.close()


func _on_button_pressed() -> void:
	socket.send_text("Ping")
