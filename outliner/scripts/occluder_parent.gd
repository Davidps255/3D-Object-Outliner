extends Node3D

var mat = preload("res://outliner/materials/invisible_occluder_material.tres")
var shader = preload("res://outliner/shaders/occlusion_shader.gdshader")

func _ready():
	for child in get_children():
		var occluder = child.duplicate()
		occluder.mesh = child.mesh
		occluder.layers = 2
		occluder.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_OFF
		
		mat.shader = shader
		occluder.material_override = mat
		
		add_child(occluder)
