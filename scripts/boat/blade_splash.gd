class_name BladeSplash extends AnimatedSprite2D

const splash_ani_name: StringName = &"splash"


func _ready() -> void:
	animation_finished.connect(on_animation_finished)


func start_splash() -> void:
	if flip_h:
		rotation_degrees = 0
	else:
		rotation_degrees = 180
	play(splash_ani_name)
	
	if !visible:
		visible = true


func on_animation_finished() -> void:
	visible = false
	stop()
