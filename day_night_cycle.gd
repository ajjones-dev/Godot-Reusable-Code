extends Node3D

var time : float
@export var day_length : float = 20.0
@export var start_time : float = 0.3
var time_rate : float

## Sun
@onready var sun : DirectionalLight3D = get_node("Sun")
@export var sun_color : Gradient
@export var sun_intensity : Curve

## Moon
@onready var moon : DirectionalLight3D = get_node("Moon")
@export var moon_color : Gradient
@export var moon_intensity : Curve

## Sky
@onready var sky : WorldEnvironment = get_node("Sky")
@export var sky_top_color : Gradient
@export var sky_horizon_color : Gradient

func _ready():
	time_rate = 1.0 / day_length
	time = start_time

func _process(delta):
	time += time_rate * delta
	if time >= .99:
		time = 0.0
	
	sun.rotation_degrees.x = time * 360.0 + 90
	sun.light_color = sun_color.sample(time)
	sun.light_energy = sun_intensity.sample(time) * 2
	
	moon.rotation_degrees.x = time * 360.0 - 90
	moon.light_color = moon_color.sample(time)
	moon.light_energy = moon_intensity.sample(time)
	
	sky.environment.sky.sky_material.set("sky_top_color", sky_top_color.sample(time))
	sky.environment.sky.sky_material.set("sky_horizon_color", sky_horizon_color.sample(time))
	sky.environment.sky.sky_material.set("ground_bottom_color", sky_top_color.sample(time))
	sky.environment.sky.sky_material.set("ground_horizon_color", sky_horizon_color.sample(time))