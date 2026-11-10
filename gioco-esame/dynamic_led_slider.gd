extends HSlider

# Configurazione grafica dei segmenti
@export var segment_width: float = 4.0   # Larghezza di ogni tacca
@export var segment_gap: float = 3.0     # Spazio tra le tacche
@export var padding_left: float = 12.0   # Margine interno a sinistra
@export var padding_right: float = 12.0  # Margine interno a destra
@export var padding_top: float = 4.0     # Margine interno sopra
@export var padding_bottom: float = 4.0  # Margine interno sotto

var color_gradient: Gradient

func _ready():
	# Configura il gradiente: Rosso ridotto di 2 barrette -> Arancione ampliato -> Verde
	color_gradient = Gradient.new()
	color_gradient.add_point(0.0, Color.RED)
	color_gradient.add_point(0.28, Color.RED)       # Rosso ora termina prima (~2 barrette in meno)
	color_gradient.add_point(0.32, Color.ORANGE)    # Arancione inizia prima (~2 barrette in più)
	color_gradient.add_point(0.70, Color.ORANGE)    # L'arancione mantiene il limite verso il verde
	color_gradient.add_point(0.75, Color.GREEN)     # Verde per il finale (75-100%)
	color_gradient.add_point(1.0, Color.GREEN)
	
	value_changed.connect(func(val): queue_redraw())
	
	# Rimuoviamo gli stili standard di Godot
	var empty = StyleBoxEmpty.new()
	add_theme_stylebox_override("slider", empty)
	add_theme_stylebox_override("grabber_area", empty)
	add_theme_stylebox_override("grabber_area_highlight", empty)
	
	# Grabber trasparente
	add_theme_icon_override("grabber", ImageTexture.create_from_image(Image.create(1, 1, false, Image.FORMAT_RGBA8)))
	add_theme_icon_override("grabber_highlight", ImageTexture.create_from_image(Image.create(1, 1, false, Image.FORMAT_RGBA8)))

func _draw():
	var usable_width = size.x - padding_left - padding_right
	var height = size.y - padding_top - padding_bottom
	
	var total_segments = int(usable_width / (segment_width + segment_gap))
	if total_segments <= 0: return
	
	var percent = (value - min_value) / (max_value - min_value)
	var active_segments = int(percent * total_segments)
	
	for i in range(total_segments):
		if i >= active_segments:
			break
			
		var x_pos = padding_left + i * (segment_width + segment_gap)
		var segment_rect = Rect2(x_pos, padding_top, segment_width, height)
		
		var segment_percent = float(i) / float(total_segments)
		var color = color_gradient.sample(segment_percent)
		
		draw_rect(segment_rect, color)
		
		# Riflesso/Glow superiore
		var glow_rect = Rect2(x_pos + 1, padding_top + 1, segment_width - 2, 2)
		draw_rect(glow_rect, Color(1, 1, 1, 0.4))
