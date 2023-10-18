extends Node
class_name StateMachine

@export var initial_state : State
var current_state : State
var states : Dictionary = {}

func init(parent : CharacterBody2D):
	for child in get_children():
		if child is State:
			states[child.name.to_lower()] = child
			child.ChangeState.connect(change_state)
	current_state = initial_state

func change_state(calling_state : State, new_state):
	if current_state != calling_state:
		return
	
	if current_state:
		current_state.exit()
	
	current_state = states.get(new_state.to_lower())
	current_state.enter()

func update_physics(delta):
	if current_state:
		current_state.update_physics(delta)

func update_process(delta):
	if current_state:
		current_state.update_process(delta)

func update_event(event):
	pass
