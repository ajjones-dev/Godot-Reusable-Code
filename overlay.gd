extends Control
class_name Overlay

## Manages various elements of the game, score, lives, and time
##
## Uses sprites to control UI based off score values
##

## Player Specific Values
@onready var player : CharacterBody2D = get_node("../../Player")

## UI Nodes
@onready var score_label : Label = get_node("ScoreContainer/Score")
@onready var time_label : Label = get_node("TimeContainer/Time")
@onready var health_label : Label = get_node("HealthContainer/Health")

## Level design
var time_remaining : float = 300.0
@export_file("*.tscn") var next_scene
@onready var goal : Area2D = get_node("../../FinishFlag")

## Called when the node enters the scene tree for the first time.
func _ready():
	update_lives_ui()
	update_score_ui()
	update_time_ui()
	goal.connect("LevelCompleted", level_complete)


## Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	time_remaining -= delta
	
	if time_remaining <= 0:
		life_adjustment(-1)
	
	update_time_ui()


## Called to set level values when player starts
func start_level(level_time : float):
	time_remaining = level_time


## Called when level is complete to adjust score
func level_complete():
	PlayerVariables.player_score += int(time_remaining)
	

## Adds score if player defeats and enemy
func add_score(value : int):
	PlayerVariables.player_score += value
	update_score_ui()


## Updates player lives count based on damage from enemy or pickup
func life_adjustment(value : int):
	PlayerVariables.player_lives += value
	update_lives_ui()


## Updates Score UI element
func update_score_ui():
	var score_length = str(PlayerVariables.player_score).length()
	var ui_score_text = str(PlayerVariables.player_score)
	
	for n in range(score_length, 8):
		ui_score_text = str("0", ui_score_text)
	
	score_label.text = ui_score_text


## Updates Level Time Remaining UI element
func update_time_ui():
	var time_length = str(int(time_remaining)).length()
	var ui_time_text = str(int(time_remaining))
	
	for n in range(time_length, 3):
		ui_time_text = str("0", ui_time_text)
	
	time_label.text = ui_time_text


## Updates Player Lives Count
func update_lives_ui():
	var ui_lives_text = str(PlayerVariables.player_lives)
	
	if ui_lives_text.length() < 2:
		ui_lives_text = str("0", ui_lives_text)
	
	health_label.text = ui_lives_text


## Transitions Screen to Game Over Screen, Updates Score
func game_over():
	get_tree().change_scene_to_file(Levels.levels[0])
