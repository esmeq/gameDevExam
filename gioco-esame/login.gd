extends Control

const SUPABASE_URL = "https://eppphhqxbckcnmkqxqmu.supabase.co"
const API_KEY = "sb_publishable_xsOWtIJpQfEZKMrMjQDruA_O4nWH7wJ"

@onready var email_input = $EmailInput
@onready var password_input = $PasswordInput
@onready var http_request = $HTTPRequest

func _ready():
	http_request.request_completed.connect(_on_request_completed)

# --- 1. BOTTONE LOGIN (Utenti già registrati) ---
# Collegato al tuo nodo LogInButton2
func _on_log_in_button_2_pressed():
	print("Tentativo di login...")
	var url = SUPABASE_URL + "/auth/v1/token?grant_type=password"
	_invia_richiesta(url)

# --- 2. BOTTONE REGISTRAZIONE (Nuovi utenti) ---
# Collegato al tuo nodo SignInButton
func _on_sign_up_button_pressed():
	print("Tentativo di registrazione...")
	var url = SUPABASE_URL + "/auth/v1/signup"
	_invia_richiesta(url)

# --- FUNZIONE DI SUPPORTO (Evita codice duplicato) ---
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

# --- 3. LETTURA DELLA RISPOSTA DAL SERVER ---
func _on_request_completed(_result, response_code, _headers, body):
	var json = JSON.parse_string(body.get_string_from_utf8())
	
	if response_code == 200:
		if json != null and json.has("access_token"):
			print("Login effettuato con successo! Token JWT: ", json.access_token.substr(0, 15), "...")
		else:
			print("Registrazione completata! Inviata email di conferma.")
	else:
		var error_msg = "Errore sconosciuto"
		if json != null:
			if json.has("error_description"): error_msg = json.error_description
			elif json.has("msg"): error_msg = json.msg
		
		print("Operazione fallita (Codice ", response_code, "): ", error_msg)
