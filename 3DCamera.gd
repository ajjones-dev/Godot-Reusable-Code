extends Node3D

@export var look_sensitivity : float = 15.0
var min_look_angle : float = -85.0
var max_look_angle : float = 85.0

var mouse_delta : Vector2 = Vector2()

@onready var player = get_parent()

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _input(event):
	if event is InputEventMouseMotion:
		mouse_delta = event.relative

func _process(delta):
	var rotate = Vector3(mouse_delta.y, mouse_delta.x, 0.0) * look_sensitivity * delta
	rotation_degrees.x -= rotate.x
	rotation_degrees.x = clamp(rotation_degrees.x, min_look_angle, max_look_angle)
	
	player.rotation_degrees.y -= rotate.y
	mouse_delta = Vector2()
