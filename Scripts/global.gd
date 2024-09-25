# Global Script
extends Node

# Global variables
var player_health: int = 100
var scene_number: int = 0 # 0-Home, 1-N5, 2-N4 ... 5-N1, 6-Hiragana/Katakana, 7-Mixed

var is_game_paused: bool = false
var is_game_over: bool = false


# Held resources dictionary array
var resources: Dictionary = {
	"n6_cards": 0,
	"n5_cards": 0,
	"n4_cards": 0,
	"n3_cards": 0,
	"n2_cards": 0,
	"n1_cards": 0
}

# Global array of spawned sprites via type  ## Honesetly, maybe useless ##
var spawned_sprite_array = []

var unsorted_jouyou_array = []

###############################################################################
# Array and ID function for Hiragana
var hiragana_array = [] #Loaded from .json
var hir_id = 1
func get_hir_id() -> String:
	var return_string = "hir-" + str(hir_id)
	hir_id += 1
	return return_string

# Array and ID function for N5 Kanji
var JLPT_N5_array = [] #Loaded from .json
var n5_id = 1
func get_n5_id() -> String:
	var return_string = "n5-" + str(n5_id)
	n5_id += 1
	return return_string

# Array and ID function for N4 Kanji
var JLPT_N4_array = [] #Loaded from .json
var n4_id = 1
func get_n4_id() -> String:
	var return_string = "n4-" + str(n4_id)
	n4_id += 1
	return return_string

# Array and ID function for N3 Kanji
var JLPT_N3_array = [] #Loaded from .json
var n3_id = 1
func get_n3_id() -> String:
	var return_string = "n3-" + str(n3_id)
	n3_id += 1
	return return_string

# Array and ID function for N2 Kanji
var JLPT_N2_array = [] #Loaded from .json
var n2_id = 1
func get_n2_id() -> String:
	var return_string = "n2-" + str(n2_id)
	n2_id += 1
	return return_string

# Array and ID function for N1 Kanji
var JLPT_N1_array = [] #Loaded from .json
var n1_id = 1
func get_n1_id() -> String:
	var return_string = "n1-" + str(n1_id)
	n1_id += 1
	return return_string

# Array and ID function for N5 Kanji
var other_kanji_array = [] #Loaded from .json
var n0_id = 1
func get_n0_id() -> String:
	var return_string = "n0-" + str(n0_id)
	n0_id += 1
	return return_string
###############################################################################


func _ready():
	load_datasets() # Load up the arrays from .json files on start
	
	##Attempt to sort loaded jouyou kanji into JLPT level arrays
	sort_kanji()


# Function that accepts a string and an int (font size), and returns a texture of that string
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


# Function to find a dictionary in spawned_sprite_array by ID (String)
func find_dict_by_id(id_value: String) -> Dictionary:
	for dict in spawned_sprite_array:
		if dict.has("ID") and dict["ID"] == id_value:
			return dict
	# If no dictionary is found, return an empty dictionary
	return {}

# Function to remove a dictionary in spawned_sprite_array by ID (String)
func remove_dict_by_id(id_value: String) -> void:
	for dict in spawned_sprite_array:
		if dict.has("ID") and dict["ID"] == id_value:
			spawned_sprite_array.erase(dict) # remove the dictionary from the array
			#print(spawned_sprite_array)
			#print("Removed entry with ID: ", id_value)
			break


func sort_kanji() -> void:
	for dict in unsorted_jouyou_array:
		if dict.has("jlpt_new") and dict["jlpt_new"] == 5:
			JLPT_N5_array.append(dict)
			
		if dict.has("jlpt_new") and dict["jlpt_new"] == 4:
			JLPT_N4_array.append(dict)
			
		if dict.has("jlpt_new") and dict["jlpt_new"] == 3:
			JLPT_N3_array.append(dict)
			
		if dict.has("jlpt_new") and dict["jlpt_new"] == 2:
			JLPT_N2_array.append(dict)
			
		if dict.has("jlpt_new") and dict["jlpt_new"] == 1:
			JLPT_N1_array.append(dict)
			
		else:
			other_kanji_array.append(dict)
			
	print("N5: ",JLPT_N5_array.size())
	print("N4: ",JLPT_N4_array.size())
	print("N3: ",JLPT_N3_array.size())
	print("N2: ",JLPT_N2_array.size())
	print("N1: ",JLPT_N1_array.size())
	print("other: ",other_kanji_array.size())


func load_datasets():
	# Load hiragana into the array
	var hiragana_01 = FileAccess.open("res://Assets/Characters/hiragana_dataset.json", FileAccess.READ)
	if hiragana_01:
		var json_text = hiragana_01.get_as_text()  # Read the file as text
		var result = JSON.parse_string(json_text)  # Evaluate the text as GDScript code (dictionary)
		hiragana_array = result # Populate the actual array
		hiragana_01.close() # close the file we jsut read
	
	# Read large jouyou kanji dataset
	var jouyou_kanji = FileAccess.open("res://Assets/Characters/kanji_jouyou_dataset.json", FileAccess.READ)
	if jouyou_kanji:
		var json_content = jouyou_kanji.get_as_text() # Read the file as text
		var parsed_data = JSON.parse_string(json_content) # Evaluate the text as a GDScript code
		
		var current_dict = parsed_data
		
		for kanji in current_dict:
			##print(kanji)
			current_dict[kanji]["kanji"] = kanji
			##print(current_dict[kanji])
			unsorted_jouyou_array.append(current_dict[kanji])
		jouyou_kanji.close() # close the file
