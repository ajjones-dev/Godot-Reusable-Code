extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = 400.0
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

##Animation Settings for AnimatedSprite2D
@onready var anim_player = get_node("AnimatedSprite2D")
var current_animation : String = "default"
var next_animation : String = "default"

func _physics_process(delta):
	velocity.x = 0
	if not is_on_floor():
		velocity.y += gravity * delta
	
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y -= JUMP_VELOCITY
	
	var direction = Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
	
	if velocity.y < 0 and not is_on_floor():
		next_animation = "jump"
	elif velocity.x == 0:
		next_animation = "default"
	elif direction < 0:
		anim_player.flip_h = true
		next_animation = "walk"
	elif direction > 0:
		anim_player.flip_h = false 
		next_animation = "walk"

	move_and_slide()
	animation_handler(next_animation)

func animation_handler(animation_to_play : String):
	if current_animation == animation_to_play:
		return
	else:
		anim_player.stop()
		anim_player.play(animation_to_play)
		current_animation = animation_to_play
