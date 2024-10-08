extends Node2D

@onready var health_number: Label = $Health_Label/Health_Number

# Path to the different kanji/character scenes
var hiragana_scene = preload("res://Scenes/character_hiragana.tscn")
var n5_kanji_scene = preload("res://Scenes/n5_sprite.tscn")
var n4_kanji_scene = preload("res://Scenes/n4_sprite.tscn")
var n3_kanji_scene = preload("res://Scenes/n3_sprite.tscn")
var n2_kanji_scene = preload("res://Scenes/n2_sprite.tscn")
var n1_kanji_scene = preload("res://Scenes/n1_sprite.tscn")
var nonjlpt_kanji_scene = preload("res://Scenes/nonjlptkanji_sprite.tscn")


#### MAIN #####################################################################
func _ready() -> void:
	
	for i in range(5):
		spawn_wave_forever(10)
	

###############################################################################
# Function to spawn hiragana sprite at random position and assign random texture
func spawn_hiragana_character():
	# Instantiate 2D Kanji scene
	var character_instance = hiragana_scene.instantiate(PackedScene.GEN_EDIT_STATE_INSTANCE)
	var sprite_node = character_instance.get_node("Sprite2D")
	
	# Pull a character from the global array of hiragana characters 
	var random_index = randi() % Global.hiragana_array.size()
	var random_dict = Global.hiragana_array[random_index]
	var character = random_dict["kana"]
	
	# Convert the text to a sprite, assign it as texture
	sprite_node.texture = Global.string_to_texture(character,128)
	##sprite_node.texture = "res://Assets/Characters/Default_Texture.png"
	
	# Randomize the x position between 0 and window width, y is fixed at 0 (top edge)
	var random_x_position = randi() % 1481 - 740  # Generates a random number between -740 and 740
	character_instance.position = Vector2(random_x_position, -400)
	##print(character_instance.position)
	
	# Add an ID to the dictionary for this spawned sprite (Used to recall the dictionary later)
	var sprite_ID = Global.get_hir_id()
	random_dict["ID"] = sprite_ID  # Add ID to dict
	# Store reference to this character in the sprite array tracking how many enemies are spawned
	Global.spawned_sprite_array.append(random_dict)
	
	# Set all needed data to the instance from the array
	character_instance.set_kana(random_dict["kana"])
	character_instance.set_reading(random_dict["reading"])
	character_instance.set_id(sprite_ID)
	##character_instance.print_data()
	
	# Add sprite to main scene
	add_child(character_instance)

# Functions to spawn kanji sprites at random position and assign random texture based on JLPT level
func spawn_n5_kanji():
	# Instantiate 2D Kanji scene
	var character_instance = n5_kanji_scene.instantiate(PackedScene.GEN_EDIT_STATE_INSTANCE)
	var sprite_node = character_instance.get_node("Sprite2D")
	
	# Pull a character from the global array of N5 kanji
	var random_index = randi() % Global.JLPT_N5_array.size()
	var random_dict = Global.JLPT_N5_array[random_index]
	var character = random_dict["kanji"]
	
	# Convert the text to a sprite, assign it as texture
	sprite_node.texture = Global.string_to_texture(character,128)
	##sprite_node.texture = "res://Assets/Characters/Default_Texture.png"
	
	# Randomize the x position between 0 and window width, y is fixed at 0 (top edge)
	var random_x_position = randi() % 1481 - 740  # Generates a random number between -740 and 740
	character_instance.position = Vector2(random_x_position, -400)
	##print(character_instance.position)
	
	# Add an ID to the dictionary for this spawned sprite (Used to recall the dictionary later)
	var sprite_ID = Global.get_n5_id()
	random_dict["ID"] = sprite_ID  # Add ID to dict
	# Store reference to this character in the sprite array tracking how many enemies are spawned
	Global.spawned_sprite_array.append(random_dict)
	
	# Set all needed data to the instance from the array
	character_instance.set_id(sprite_ID)
	character_instance.set_kanji(random_dict["kanji"])
	character_instance.set_reading(str(random_dict["readings_on"], ",", random_dict["readings_kun"]))
	character_instance.set_meaning(str(random_dict["meanings"]))
	##character_instance.print_data()
	
	# Add sprite to main scene
	add_child(character_instance)

func spawn_n4_kanji():
	# Instantiate 2D Kanji scene
	var character_instance = n4_kanji_scene.instantiate(PackedScene.GEN_EDIT_STATE_INSTANCE)
	var sprite_node = character_instance.get_node("Sprite2D")
	
	# Pull a character from the global array of N4 kanji
	var random_index = randi() % Global.JLPT_N4_array.size()
	var random_dict = Global.JLPT_N4_array[random_index]
	var character = random_dict["kanji"]
	
	# Convert the text to a sprite, assign it as texture
	sprite_node.texture = Global.string_to_texture(character,128)
	##sprite_node.texture = "res://Assets/Characters/Default_Texture.png"
	
	# Randomize the x position between 0 and window width, y is fixed at 0 (top edge)
	var random_x_position = randi() % 1481 - 740  # Generates a random number between -740 and 740
	character_instance.position = Vector2(random_x_position, -400)
	##print(character_instance.position)
	
	# Add an ID to the dictionary for this spawned sprite (Used to recall the dictionary later)
	var sprite_ID = Global.get_n4_id()
	random_dict["ID"] = sprite_ID  # Add ID to dict
	# Store reference to this character in the sprite array tracking how many enemies are spawned
	Global.spawned_sprite_array.append(random_dict)
	
	# Set all needed data to the instance from the array
	character_instance.set_id(sprite_ID)
	character_instance.set_kanji(random_dict["kanji"])
	character_instance.set_reading(str(random_dict["readings_on"], ",", random_dict["readings_kun"]))
	character_instance.set_meaning(str(random_dict["meanings"]))
	##character_instance.print_data()
	
	# Add sprite to main scene
	add_child(character_instance)

func spawn_n3_kanji():
	# Instantiate 2D Kanji scene
	var character_instance = n3_kanji_scene.instantiate(PackedScene.GEN_EDIT_STATE_INSTANCE)
	var sprite_node = character_instance.get_node("Sprite2D")
	
	# Pull a character from the global array of N3 kanji
	var random_index = randi() % Global.JLPT_N3_array.size()
	var random_dict = Global.JLPT_N3_array[random_index]
	var character = random_dict["kanji"]
	
	# Convert the text to a sprite, assign it as texture
	sprite_node.texture = Global.string_to_texture(character,128)
	##sprite_node.texture = "res://Assets/Characters/Default_Texture.png"
	
	# Randomize the x position between 0 and window width, y is fixed at 0 (top edge)
	var random_x_position = randi() % 1481 - 740  # Generates a random number between -740 and 740
	character_instance.position = Vector2(random_x_position, -400)
	##print(character_instance.position)
	
	# Add an ID to the dictionary for this spawned sprite (Used to recall the dictionary later)
	var sprite_ID = Global.get_n3_id()
	random_dict["ID"] = sprite_ID  # Add ID to dict
	# Store reference to this character in the sprite array tracking how many enemies are spawned
	Global.spawned_sprite_array.append(random_dict)
	
	# Set all needed data to the instance from the array
	character_instance.set_id(sprite_ID)
	character_instance.set_kanji(random_dict["kanji"])
	character_instance.set_reading(str(random_dict["readings_on"], ",", random_dict["readings_kun"]))
	character_instance.set_meaning(str(random_dict["meanings"]))
	##character_instance.print_data()
	
	# Add sprite to main scene
	add_child(character_instance)

func spawn_n2_kanji():
	# Instantiate 2D Kanji scene
	var character_instance = n2_kanji_scene.instantiate(PackedScene.GEN_EDIT_STATE_INSTANCE)
	var sprite_node = character_instance.get_node("Sprite2D")
	
	# Pull a character from the global array of N2 kanji
	var random_index = randi() % Global.JLPT_N2_array.size()
	var random_dict = Global.JLPT_N2_array[random_index]
	var character = random_dict["kanji"]
	
	# Convert the text to a sprite, assign it as texture
	sprite_node.texture = Global.string_to_texture(character,128)
	##sprite_node.texture = "res://Assets/Characters/Default_Texture.png"
	
	# Randomize the x position between 0 and window width, y is fixed at 0 (top edge)
	var random_x_position = randi() % 1481 - 740  # Generates a random number between -740 and 740
	character_instance.position = Vector2(random_x_position, -400)
	##print(character_instance.position)
	
	# Add an ID to the dictionary for this spawned sprite (Used to recall the dictionary later)
	var sprite_ID = Global.get_n2_id()
	random_dict["ID"] = sprite_ID  # Add ID to dict
	# Store reference to this character in the sprite array tracking how many enemies are spawned
	Global.spawned_sprite_array.append(random_dict)
	
	# Set all needed data to the instance from the array
	character_instance.set_id(sprite_ID)
	character_instance.set_kanji(random_dict["kanji"])
	character_instance.set_reading(str(random_dict["readings_on"], ",", random_dict["readings_kun"]))
	character_instance.set_meaning(str(random_dict["meanings"]))
	##character_instance.print_data()
	
	# Add sprite to main scene
	add_child(character_instance)

func spawn_n1_kanji():
	# Instantiate 2D Kanji scene
	var character_instance = n1_kanji_scene.instantiate(PackedScene.GEN_EDIT_STATE_INSTANCE)
	var sprite_node = character_instance.get_node("Sprite2D")
	
	# Pull a character from the global array of N1 kanji
	var random_index = randi() % Global.JLPT_N1_array.size()
	var random_dict = Global.JLPT_N1_array[random_index]
	var character = random_dict["kanji"]
	
	# Convert the text to a sprite, assign it as texture
	sprite_node.texture = Global.string_to_texture(character,128)
	##sprite_node.texture = "res://Assets/Characters/Default_Texture.png"
	
	# Randomize the x position between 0 and window width, y is fixed at 0 (top edge)
	var random_x_position = randi() % 1481 - 740  # Generates a random number between -740 and 740
	character_instance.position = Vector2(random_x_position, -400)
	##print(character_instance.position)
	
	# Add an ID to the dictionary for this spawned sprite (Used to recall the dictionary later)
	var sprite_ID = Global.get_n1_id()
	random_dict["ID"] = sprite_ID  # Add ID to dict
	# Store reference to this character in the sprite array tracking how many enemies are spawned
	Global.spawned_sprite_array.append(random_dict)
	
	# Set all needed data to the instance from the array
	character_instance.set_id(sprite_ID)
	character_instance.set_kanji(random_dict["kanji"])
	character_instance.set_reading(str(random_dict["readings_on"], ",", random_dict["readings_kun"]))
	character_instance.set_meaning(str(random_dict["meanings"]))
	##character_instance.print_data()
	
	# Add sprite to main scene
	add_child(character_instance)

func spawn_nonjlpt_kanji():
	# Instantiate 2D Kanji scene
	var character_instance = nonjlpt_kanji_scene.instantiate(PackedScene.GEN_EDIT_STATE_INSTANCE)
	var sprite_node = character_instance.get_node("Sprite2D")
	
	# Pull a character from the global array of non jlpt kanji
	var random_index = randi() % Global.other_kanji_array.size()
	var random_dict = Global.other_kanji_array[random_index]
	var character = random_dict["kanji"]
	
	# Convert the text to a sprite, assign it as texture
	sprite_node.texture = Global.string_to_texture(character,128)
	##sprite_node.texture = "res://Assets/Characters/Default_Texture.png"
	
	# Randomize the x position between 0 and window width, y is fixed at 0 (top edge)
	var random_x_position = randi() % 1481 - 740  # Generates a random number between -740 and 740
	character_instance.position = Vector2(random_x_position, -400)
	##print(character_instance.position)
	
	# Add an ID to the dictionary for this spawned sprite (Used to recall the dictionary later)
	var sprite_ID = Global.get_n0_id()
	random_dict["ID"] = sprite_ID  # Add ID to dict
	# Store reference to this character in the sprite array tracking how many enemies are spawned
	Global.spawned_sprite_array.append(random_dict)
	
	# Set all needed data to the instance from the array
	character_instance.set_id(sprite_ID)
	character_instance.set_kanji(random_dict["kanji"])
	character_instance.set_reading(str(random_dict["readings_on"], ",", random_dict["readings_kun"]))
	character_instance.set_meaning(str(random_dict["meanings"]))
	##character_instance.print_data()
	
	# Add sprite to main scene
	add_child(character_instance)

###############################################################################

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	# Move all children towards (0, 0)
	for child in get_children():
		if child.is_in_group("character"):
			_move_to_target(_delta, child)
	
	# Check health value and update
	health_number.text = str(Global.player_health)

# Function to move the character towards (0, 248) - The center of desk
func _move_to_target(delta, character_instance):
	# Get the current position of the character
	var current_position = character_instance.position
	
	# Calculate direction towards (0, 0)
	var direction = (Vector2(0, 248) - current_position).normalized()
	
	# Move the character towards (0, 0) with a given speed
	character_instance.position += direction * character_instance.speed * delta


### Function to call spawn() functions basde on provided level until the player dies
## JLPT 1-5, 0 = nonJLPT Kanji, 6 = hiragana, 10 = random mix
func spawn_wave_forever(level: int):
	# While alive spawn waves based on difficulty level
	while Global.player_health > 0:
		if level == 6:
			spawn_hiragana_character() 
		if level == 5:
			spawn_n5_kanji()
		if level == 4:
			spawn_n4_kanji()
		if level == 3:
			spawn_n3_kanji()
		if level == 2:
			spawn_n2_kanji()
		if level == 1:
			spawn_n1_kanji()
		if level == 0:
			spawn_nonjlpt_kanji()
		if level == 10:
			var x = randi() % 7
			#print("Spawning level ", x)
			if x == 6:
				spawn_hiragana_character() 
			if x == 5:
				spawn_n5_kanji()
			if x == 4:
				spawn_n4_kanji()
			if x == 3:
				spawn_n3_kanji()
			if x == 2:
				spawn_n2_kanji()
			if x == 1:
				spawn_n1_kanji()
			if x == 0:
				spawn_nonjlpt_kanji()
		
		
		# Pause between spawns - 2 seconds
		await get_tree().create_timer(2.0).timeout


# Input event - escape
func _input(event):
	if event.is_action_pressed("escape"):
		##print("Escape Pressed")
		get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")
