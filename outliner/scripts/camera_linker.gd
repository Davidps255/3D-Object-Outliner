extends Camera3D

@export var main_camera: Camera3D

func _process(_delta):
	if main_camera:
		global_transform = main_camera.global_transform
		fov = main_camera.fov
