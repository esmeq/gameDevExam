extends Control

@onready var music_slider = %Music
@onready var brightness_slider = %Brightness
@onready var logout_button = %LogOutButton
@onready var back_button = %BackButton
@onready var canvas_modulate = %CanvasModulate

var color_gradient = Gradient.new()

func _ready():
	# 1. Configurazione dei colori del gradiente (0-100)
	color_gradient.add_point(0.0, Color.RED)
	color_gradient.add_point(0.5, Color.RED)
	color_gradient.add_point(0.51, Color.ORANGE)
	color_gradient.add_point(0.75, Color.ORANGE)
	color_gradient.add_point(0.76, Color.GREEN)
	color_gradient.add_point(1.0, Color.GREEN)
	
	# 2. Impostazione dei valori iniziali degli slider (da 0 a 100)
	music_slider.min_value = 0
	music_slider.max_value = 100
	music_slider.value = db_to_linear(AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Master"))) * 100
	
	brightness_slider.min_value = 0
	brightness_slider.max_value = 100
	brightness_slider.value = 100
	
	# 3. Connessione dei segnali
	music_slider.value_changed.connect(_on_music_value_changed)
	brightness_slider.value_changed.connect(_on_brightness_value_changed)
	logout_button.pressed.connect(_on_logout_pressed)
	back_button.pressed.connect(_on_back_pressed)
	
	# Aggiorniamo i colori iniziali delle barre
	_update_slider_color(music_slider)
	_update_slider_color(brightness_slider)
	
	# Cursore
	CursorManager.set_cursor(CursorManager.State.MENU)

# Gestione Volume Musica
func _on_music_value_changed(value: float):
	_update_slider_color(music_slider)
	var linear_val = value / 100.0
	var bus_index = AudioServer.get_bus_index("Master")
	if linear_val <= 0.01:
		AudioServer.set_bus_mute(bus_index, true)
	else:
		AudioServer.set_bus_mute(bus_index, false)
		AudioServer.set_bus_volume_db(bus_index, linear_to_db(linear_val))

# Gestione Luminosità
func _on_brightness_value_changed(value: float):
	_update_slider_color(brightness_slider)
	var brightness_factor = (value / 100.0) * 1.3 + 0.2
	if canvas_modulate:
		canvas_modulate.color = Color(brightness_factor, brightness_factor, brightness_factor, 1.0)

func _update_slider_color(slider: HSlider):
	var percent = (slider.value - slider.min_value) / (slider.max_value - slider.min_value)
	var current_color = color_gradient.sample(percent)
	
	var stylebox = slider.get_theme_stylebox("slider")
	if not stylebox:
		stylebox = slider.get_theme_stylebox("grabber_area")
		
	if stylebox:
		var unique_stylebox = stylebox.duplicate()
		if unique_stylebox is StyleBoxFlat:
			unique_stylebox.bg_color = current_color
			slider.add_theme_stylebox_override("slider", unique_stylebox)
			slider.add_theme_stylebox_override("grabber_area", unique_stylebox)

# ---> MODIFICA QUI <---
func _on_logout_pressed():
	print("Disconnessione in corso...")
	
	# Elimination file di sessione locale
	if FileAccess.file_exists("user://session.json"):
		DirAccess.remove_absolute("user://session.json")
		print("Sessione eliminata da disco.")
	
	get_tree().change_scene_to_file("res://login.tscn")

func _on_back_pressed():
	get_tree().change_scene_to_file("res://main_menu.tscn")
