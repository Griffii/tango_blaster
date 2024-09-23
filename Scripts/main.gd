extends Node2D

@onready var health_number: Label = $Health_Label/Health_Number
@onready var character_hiragana: CharacterBody2D = $character_hiragana
@onready var student_area_2d: Area2D = $Area2D



# Preload the sprite character to spawn
var character_scene = preload("res://Scenes/character_hiragana.tscn")

# Array of textures - Hiragana
var textures_hiragana = [
	preload("res://Assets/Characters/Hiragana/あ.png"),
	preload("res://Assets/Characters/Hiragana/い.png"),
	preload("res://Assets/Characters/Hiragana/う.png"),
	preload("res://Assets/Characters/Hiragana/え.png"),
	preload("res://Assets/Characters/Hiragana/お.png")
]

# Set variable for student
var player: CharacterBody2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	#Spawn 5 sprites
	for i in range(5):
		spawn_character_N6()



# Function to spawn hiragana sprite at random position and assign random texture
func spawn_character_N6():
	# Instance the sprite scene
	var character_instance = character_scene.instantiate(PackedScene.GEN_EDIT_STATE_INSTANCE)
	
	# Get the Sprite2D child (assuming it's named '2dsprite')
	var sprite_node = character_instance.get_node("Sprite2D")
	
	# Choose a random texture from the hiragana texture array
	var random_texture = textures_hiragana[randi() % textures_hiragana.size()]
	
	# Assign the random texture to the sprite texture property
	sprite_node.texture = random_texture
	
	# Randomize the x position between 0 and window width, y is fixed at 0 (top edge)
	var random_x_position = randi() % 1481 - 740  # Generates a random number between -740 and 740
	character_instance.position = Vector2(random_x_position, -400)
	
	# Add sprite to current scene
	add_child(character_instance)
	
	# Store reference to this character in the sprite array
	Global.sprite_array_type.append(character_instance.type)



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
