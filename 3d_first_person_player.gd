extends CharacterBody3D

#physics
@export var move_speed : float = 5.0
@export var jump_force : float = 5.0
var gravity : float = 12.0

#camera and look
var min_look_angle : float = -90.0
var max_look_angle : float = 90.0
var look_sensitivity : float = 10.0

#vectors
var mouse_delta : Vector2 = Vector2()

#components
@onready var camera : Camera3D = get_node("Camera3D")

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
func _physics_process(delta):
	velocity.x = 0
	velocity.z = 0
	
	if not is_on_floor():
		velocity.y -= gravity * delta
	
	if Input.is_action_just_pressed("Jump") and is_on_floor():
		velocity.y = jump_force
		
	var input_dir = Input.get_vector("Left", "Right", "Forward", "Back")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * move_speed
		velocity.z = direction.z * move_speed
	else:
		velocity.x = move_toward(velocity.x, 0, move_speed)
		velocity.z = move_toward(velocity.z, 0, move_speed)

	move_and_slide()

func _process(delta):
	camera.rotation_degrees.x -= mouse_delta.y * look_sensitivity * delta
	camera.rotation_degrees.x = clamp(camera.rotation_degrees.x, min_look_angle, max_look_angle)
	
	rotation_degrees.y -= mouse_delta.x * look_sensitivity * delta
	
	mouse_delta  = Vector2()

func _input(event):
	if event is InputEventMouseMotion:
		mouse_delta = event.relative

