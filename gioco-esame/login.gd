extends Control

const NEXT_SCENE_PATH = "res://vignette.tscn"
const SUPABASE_URL = "https://eppphhqxbckcnmkqxqmu.supabase.co"
const API_KEY = "sb_publishable_xsOWtIJpQfEZKMrMjQDruA_O4nWH7wJ"

@onready var email_input = $EmailInput
@onready var password_input = $PasswordInput
@onready var http_request = $HTTPRequest

# Variabile di stato per capire se l'utente sta facendo il login o la registrazione
var is_logging_in: bool = false

func _ready():
	http_request.request_completed.connect(_on_request_completed)
	
	# Cursore
	CursorManager.set_cursor(CursorManager.State.MENU)

# 1. BOTTONE LOGIN (Utenti già registrati)
func _on_log_in_button_pressed():
	print("Tentativo di login...")
	is_logging_in = true
	var url = SUPABASE_URL + "/auth/v1/token?grant_type=password"
	_invia_richiesta(url)

# 2. BOTTONE REGISTRAZIONE (Nuovi utenti)
func _on_sign_up_button_pressed():
	print("Tentativo di registrazione...")
	is_logging_in = false
	var url = SUPABASE_URL + "/auth/v1/signup"
	_invia_richiesta(url)

# FUNZIONE DI SUPPORTO
func _invia_richiesta(url: String):
	var headers = [
		"apikey: " + API_KEY,
		"Content-Type: application/json"
	]
	var body = JSON.stringify({
		"email": email_input.text,
		"password": password_input.text
	})
	http_request.request(url, headers, HTTPClient.METHOD_POST, body)

# 3. LETTURA DELLA RISPOSTA DAL SERVER (Gestione Asincrona)
func _on_request_completed(_result, response_code, _headers, body):
	var json = JSON.parse_string(body.get_string_from_utf8())
	
	if response_code == 200:
		if is_logging_in:
			# Se stavamo facendo il login e riceviamo il token
			if json != null and json.has("access_token"):
				print("Login effettuato con successo! Avvio transizione...")
				
				# ---> PUNTO 1: Salva i dati restituiti da Supabase su disco <---
				save_session(json)
				
				get_tree().change_scene_to_file(NEXT_SCENE_PATH)
				
		else:
			# Se stavamo facendo la registrazione
			print("Registrazione completata! Inviata email di conferma.")
	else:
		var error_msg = "Errore sconosciuto"
		if json != null:
			if json.has("error_description"): error_msg = json.error_description
			elif json.has("msg"): error_msg = json.msg
		
		print("Operazione fallita (Codice ", response_code, "): ", error_msg)

# ---> PUNTO 2: Nuova funzione in fondo al file per scrivere il file locale <---
func save_session(session_data: Dictionary) -> void:
	var file = FileAccess.open("user://session.json", FileAccess.WRITE)
	if file:
		var json_string = JSON.stringify(session_data)
		file.store_string(json_string)
		file.close()
		print("Sessione salvata con successo in user://session.json")
