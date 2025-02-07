class_name WorldTest extends Node2D

@onready var boat: Boat = $Boat


func receive_serial_data(data):
	var parsed_data = JSON.parse(data)
	var serialData = parsed_data.serialData
	# 根据串口数据更新小船的位置或其他属性
	boat.position.x += serialData.x
	boat.position.y += serialData.y

# 用键盘模拟划船动作
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("row"):
		boat.power_input = 240
		boat.water_resistance = 0.2
	elif event.is_action_released("row"):
		boat.power_input = 0
		boat.water_resistance = 10.0
