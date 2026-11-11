extends Control

@onready var glitch = get_node_or_null("Glitch")
@onready var vignetta = get_node_or_null("Vignetta")
@onready var freccia = get_node_or_null("Freccia")

func _ready():
	
	#Cursore
	CursorManager.set_cursor(CursorManager.State.MENU)
	
	# Controlli di sicurezza: modifichiamo i nodi solo se esistono
	if glitch:
		glitch.modulate = Color(0, 0, 0, 1)
		glitch.visible = true
		
	if vignetta:
		vignetta.modulate.a = 0.0
		
	var tween = create_tween()
	
	if glitch:
		# Il nero sfuma via verso la trasparenza in 8 secondi
		tween.tween_property(glitch, "modulate:a", 0.0, 8.0)
		
	if vignetta:
		# Contemporaneamente la vignetta appare in 4 secondi
		tween.parallel().tween_property(vignetta, "modulate:a", 1.0, 8.0)
		
	if glitch:
		# Finito l'effetto, spegniamo il nodo nero per non bloccare i click sulla freccia
		tween.tween_callback(func(): glitch.visible = false)
		
	if freccia:
		freccia.pressed.connect(_on_freccia_pressed)

func _on_freccia_pressed():
	print("Passaggio al gioco principale...")
	get_tree().change_scene_to_file("res://gameplay.tscn")
