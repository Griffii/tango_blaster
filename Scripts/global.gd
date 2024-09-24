# Global Script
extends Node

# Global variables
var player_health: int = 100
var scene_number: int = 0 # 0-Home, 1-N5, 2-N4 ... 5-N1, 6-Hiragana/Katakana, 7-Mixed

# Held resources variables
var n5_cards = 0
var n4_cards = 0
var n3_cards = 0
var n2_cards = 0
var n1_cards = 0
var n0_cards = 0

var is_game_paused: bool = false
var is_game_over: bool = false

# Character (enemy) variables
var char_wave_number: int =1
var total_char_in_wave: int = 0
var char_spawn_rate: float = 1.0

var move_speed = 70 # Speed if not defined in node itself

# Global array of spawned sprites via type
var spawned_sprite_array = []

# Dict Array for Hiragana
var hiragana_array = []

var JLPT_N5_array = []

func _ready():
	load_datasets()


# Function that accepts a string and an int (font size), and returns a texture
func string_to_texture(text: String, font_size: int) -> Texture2D:
	
	# Create a SubViewport
	var sub_viewport = SubViewport.new()
	
	# Transparent background
	sub_viewport.transparent_bg = true
	
	# Dynamically calculate the viewport size based on the length of the text and font size
	var text_length = text.length()
	var viewport_width = text_length * font_size  # Rough estimate of width
	var viewport_height = font_size * 1.5  # Slightly larger than font size for height
	# Set the viewport size based on the calculated values
	sub_viewport.size = Vector2(viewport_width, viewport_height)
	
	#Add the viewport so it can accept the label
	add_child(sub_viewport)
	
	# Create a Label and configure the text and font size
	var label = Label.new()
	label.text = text
	label.position = Vector2(0, 0)  # Position the label inside the viewport
	# Create and set a custom font
	var font_file = load("res://Assets/Fonts/NotoSansJP-Regular.ttf") as FontFile  # Load your font file here
	# Apply font to label, theme overrides
	label.add_theme_font_override("font", font_file)
	label.add_theme_font_size_override("font_size", font_size)
	label.add_theme_color_override("font_color", Color.BLACK)
	# Add the Label to the SubViewport
	sub_viewport.add_child(label)
	
	# Return the texture generated from the SubViewport
	return sub_viewport.get_texture()
	


func load_datasets():
	
	# Load hiragana into the array
	var hiragana_01 = FileAccess.open("res://Assets/Characters/Hiragana/hiragana_dataset.json", FileAccess.READ)
	if hiragana_01:
		var json_text = hiragana_01.get_as_text()  # Read the file as text
		var result = JSON.parse_string(json_text)  # Evaluate the text as GDScript code (array of dictionaries)
		hiragana_array = result # Populate the actual array
		hiragana_01.close() # close the file we jsut read
	
	#var JLPT_N5_01 = 
	
