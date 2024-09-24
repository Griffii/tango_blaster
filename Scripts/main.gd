extends Node2D

@onready var health_number: Label = $Health_Label/Health_Number


# Path to the Hiragana character scene
var hiragana_scene = preload("res://Scenes/character_hiragana.tscn")



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	for i in range(10):
		spawn_wave_forever()
	
	


# Function to spawn hiragana sprite at random position and assign random texture
func spawn_hiragana_character():
	
	# Instantiate 2D Kanji scene
	var character_instance = hiragana_scene.instantiate(PackedScene.GEN_EDIT_STATE_INSTANCE)
	var sprite_node = character_instance.get_node("Sprite2D")
	
	# Pull a character from the array - 
	var random_index = randi() % Global.hiragana_array.size()
	var random_dict = Global.hiragana_array[random_index]
	var character = random_dict["kana"]
	##print("Selected: ", character)
	
	# Convert the text to a sprite, assign it as texture
	sprite_node.texture = Global.string_to_texture(character,128)
	##sprite_node.texture = "res://Assets/Characters/Default_Texture.png"
	
	
	# Randomize the x position between 0 and window width, y is fixed at 0 (top edge)
	var random_x_position = randi() % 1481 - 740  # Generates a random number between -740 and 740
	character_instance.position = Vector2(random_x_position, -400)
	##print(character_instance.position)
	
	# Add sprite to main scene
	add_child(character_instance)
	
	# Store reference to this character in the sprite array tracking how many enemies are spawned
	##Global.spawned_sprite_array.append(random_dict)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	# Move all children towards (0, 0)
	for child in get_children():
		if child is AnimatableBody2D:
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


func spawn_wave_forever():
	# Call the spawn_hiragana_sprite() function from the hiragana_sprite.gd script
	while Global.player_health > 0:
		spawn_hiragana_character()  # Call the function
		
		# Pause between spawns - 2 seconds
		await get_tree().create_timer(2.0).timeout
