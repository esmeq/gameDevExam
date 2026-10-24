extends Node3D
## Demo: slowly rotating camera; press Left/Right (or A/D) to cycle through the skies.
const ENVS := [
	"res://addons/skybox_sampler/environments/01_teal_magenta_nebula.tres",
	"res://addons/skybox_sampler/environments/09_ringed_gas_giant.tres",
	"res://addons/skybox_sampler/environments/14_supernova_remnant.tres",
	"res://addons/skybox_sampler/environments/02_golden_hour.tres",
	"res://addons/skybox_sampler/environments/08_thunderstorm.tres",
	"res://addons/skybox_sampler/environments/12_moonlit_night.tres"
]
const NAMES := [
	"Teal & Magenta Nebula",
	"Ringed Gas Giant",
	"Supernova Remnant",
	"Golden Hour",
	"Thunderstorm",
	"Moonlit Night"
]
@export var rotate_speed := 0.06
var idx := 0
@onready var we: WorldEnvironment = $WorldEnvironment
@onready var cam: Camera3D = $Camera3D
@onready var label: Label = $UI/Label

func _ready() -> void:
	select(0)

func select(i: int) -> void:
	idx = posmod(i, ENVS.size())
	we.environment = load(ENVS[idx])
	label.text = "%s   (%d/%d)   Left/Right: change sky" % [NAMES[idx], idx + 1, ENVS.size()]

func _process(delta: float) -> void:
	cam.rotate_y(rotate_speed * delta)

func _unhandled_input(e: InputEvent) -> void:
	if e.is_action_pressed("ui_right"):
		select(idx + 1)
	elif e.is_action_pressed("ui_left"):
		select(idx - 1)
