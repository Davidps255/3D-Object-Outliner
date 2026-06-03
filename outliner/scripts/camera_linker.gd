extends Camera3D

@export var main_camera: Camera3D

func _ready():
	fov = main_camera.fov

func _process(_delta):
	if main_camera:
		global_transform = main_camera.global_transform
