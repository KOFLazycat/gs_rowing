class_name WorldTest extends Node2D

@onready var boat: Boat = $Boat


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
