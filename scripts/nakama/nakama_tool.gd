class_name NakamaTool
extends Node

@export var send_button: Button
@export var boat: Boat
@export var label: Label

var client: NakamaClient
var session: NakamaSession
var socket: NakamaSocket
var createdMatch

func _ready():
	var scheme: String = "http"
	var host: String = "54.178.221.15"
	var port: int = 7350
	var server_key: String = "defaultkey"
	client = Nakama.create_client(server_key, host, port, scheme)
	
	var email: String = "lushoulei0552@163.com"
	var password: String = "shoulei0123"
	session = await client.authenticate_email_async(email, password)
	
	socket = Nakama.create_socket_from(client)
	socket.connected.connect(self._on_socket_connected)
	socket.closed.connect(self._on_socket_closed)
	socket.received_error.connect(self._on_socket_error)
	
	socket.received_match_presence.connect(_on_socket_received_match_presence)
	socket.received_match_state.connect(_on_socket_received_match_state)
	await socket.connect_async(session)
	
	send_button.pressed.connect(_on_send_button_pressed)


func _on_socket_connected() -> void:
	print("Socket connected.")
	createdMatch = await socket.create_match_async("test_match")
	if createdMatch.is_exception():
		print("Failed to create match " + str(createdMatch))
		return
	
	print("Create Match: " + str(createdMatch.match_id))


func _on_socket_closed() -> void:
	print("Socket closed.")


func _on_socket_error(err) -> void:
	printerr("Socket error %s" % err)


func _on_socket_received_match_presence(p_match_presence_event: NakamaRTAPI.MatchPresenceEvent) -> void:
	print("_on_socket_received_match_presence: " + str(p_match_presence_event))


func _on_socket_received_match_state(p_match_state: NakamaRTAPI.MatchData) -> void:
	var match_data = JSON.parse_string(p_match_state.data)
	var power: float = match_data.data.power
	label.text = str(power)
	if power > 1:
		boat.power_input = 240
		boat.water_resistance = 0.2
	else:
		boat.power_input = 0
		boat.water_resistance = 50.0


func _on_send_button_pressed() -> void:
	var data: Dictionary = {
		"user_id": 112223,
		"user_name": "lushoulei"
	}
	socket.send_match_state_async(createdMatch.match_id, 0, JSON.stringify(data))
