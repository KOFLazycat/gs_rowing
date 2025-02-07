class_name Boat extends CharacterBody2D

@onready var ripple_effect: AnimatedSprite2D = $RippleEffect

var speed: float = 0.0
var power_input: float = 0.0  # 划船机传入的实时功率（单位：瓦特）
var water_resistance: float = 0.5  # 水阻力系数


func _physics_process(delta: float) -> void:
	# 根据功率计算加速度（假设功率与加速度成正比）
	var acceleration = power_input * 0.1
	speed += acceleration * delta
	speed = max(speed - water_resistance * delta, 0)  # 自然减速
	
	if speed > 0:
		ripple_effect.visible = true
	else:
		ripple_effect.visible = false
	
	# 移动船体
	velocity = Vector2.UP * speed
	move_and_slide()
