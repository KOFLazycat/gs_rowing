extends Node2D

@onready var boat: Boat = $Boat
@onready var button: Button = $Button
@onready var label: Label = $Label

# The URL we will connect to.
@export var websocket_url = "wss://echo.websocket.org"

# Our WebSocketClient instance.
var socket = WebSocketPeer.new()

func _ready():
	# Initiate connection to the given URL.
	var err = socket.connect_to_url(websocket_url)
	if err != OK:
		print("Unable to connect")
		set_process(false)
	else:
		# Wait for the socket to connect.
		await get_tree().create_timer(2).timeout

		# Send data.
		socket.send_text("Test packet")

func _process(_delta):
	# Call this in _process or _physics_process. Data transfer and state updates
	# will only happen when calling this function.
	socket.poll()

	# get_ready_state() tells you what state the socket is in.
	var state = socket.get_ready_state()

	# WebSocketPeer.STATE_OPEN means the socket is connected and ready
	# to send and receive data.
	if state == WebSocketPeer.STATE_OPEN:
		while socket.get_available_packet_count():
			print("Got data from server: ", socket.get_packet().get_string_from_utf8())

	# WebSocketPeer.STATE_CLOSING means the socket is closing.
	# It is important to keep polling for a clean close.
	elif state == WebSocketPeer.STATE_CLOSING:
		pass

	# WebSocketPeer.STATE_CLOSED means the connection has fully closed.
	# It is now safe to stop polling.
	elif state == WebSocketPeer.STATE_CLOSED:
		# The code will be -1 if the disconnection was not properly notified by the remote peer.
		var code = socket.get_close_code()
		print("WebSocket closed with code: %d. Clean: %s" % [code, code != -1])
		set_process(false) # Stop processing.

#var _callback_ref = JavaScriptBridge.create_callback(_my_callback)
#
#
#func _ready():
	#JavaScriptBridge.eval('''
		#const button = document.querySelector('button');
  		#button.addEventListener('click', connectSerial);
	#''')  # 初始化连接
	## Get the JavaScript `window` object.
	##var window = JavaScriptBridge.get_interface("window")
	## Call the JavaScript `myFunc` function defined in the custom HTML head.
	##window.receive_message_from_godot("godot use uniapp")
	## Set the `window.onbeforeunload` DOM event listener.
	##window.onbeforeunload = _callback_ref
#
#
#func _my_callback(args):
	## Get the first argument (the DOM event in our case).
	#var js_event = args[0]
	## Call preventDefault and set the `returnValue` property of the DOM event.
	#js_event.preventDefault()
	#js_event.returnValue = ''
	#print("_my_callback_my_callback_my_callback_my_callback")


# 用键盘模拟划船动作
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("row"):
		#var js_code = "window.receiveFromGodot(1111)";
		## 通过JavaScriptBridge执行JS代码
		#JavaScriptBridge.eval(js_code)
		boat.power_input = 240
		boat.water_resistance = 0.2
	elif event.is_action_released("row"):
		#var js_code = "console.log(3333)";
		## 通过JavaScriptBridge执行JS代码
		#JavaScriptBridge.eval(js_code)
		boat.power_input = 0
		boat.water_resistance = 10.0
