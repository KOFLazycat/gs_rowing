class_name WorldTest extends Node2D

@onready var boat: Boat = $Boat


# 用键盘模拟划船动作
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("row"):
		boat.power_input = 240
		boat.water_resistance = 0.2
	elif event.is_action_released("row"):
		boat.power_input = 0
		boat.water_resistance = 10.0
