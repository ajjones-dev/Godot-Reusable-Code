extends Node
class_name State

@export var animation_name : String
@onready var animation_player : AnimatedSprite2D = get_node("../../AnimatedSprite2D")
signal ChangeState

var gravity : int = ProjectSettings.get_setting("physics/2d/default_gravity")

## Skeleton functions to be handled by individual states
func enter():
	animation_player.play(animation_name)

func exit():
	animation_player.stop()

func update_event(event):
	pass

func update_process(delta):
	pass

func update_physics(delta):
	pass
