extends Area2D

var id = ""
var kanji = ""
var reading = ""
var meaning = ""
var health = 2
var damage = 2
var speed = 100

## Functions to interact with variables - set/get
func set_id(new_id: String):
	id = new_id
func get_id() -> String:
	return id

func set_kanji(new_kanji: String):
	kanji = new_kanji
func get_kanji() -> String:
	return kanji

func set_reading(new_reading: String):
	reading = new_reading
func get_reading() -> String:
	return reading

func set_meaning(new_meaning: String):
	meaning = new_meaning
func get_meaning() -> String:
	return meaning

func get_damage() -> int:
	return damage
func get_health() -> int:
	return health
func get_speed() -> int:
	return speed

#DEBUG Function to print all stored data in a doctionary format
func print_data():
	print(id, ", ", kanji, ", ", reading, ", ", meaning,", ", health, ", ", damage, ", ", speed)

# Remove sprite when collided with Player
func _on_area_entered(area: Area2D) -> void:
	# Check what it collided with, if player despawn
	if area.is_in_group("student"):
		despawn()

# Function to take damage
func take_damage(damage_amount: int):
	health -= damage_amount
	if health <= 0:
		despawn()

# Deletes the node
func despawn():
	# Check ID and remove from global array of spawned sprites
	Global.remove_dict_by_id(id)
	print("Destroyed: ", id, " - ", kanji)
	
	# Check health, if 0 the sprite was destroyed and should award points to the player
	##Maybe this should have a seperate function, but this works for now
	if health <= 0:
		Global.resources["n4_cards"] += 1
		#print(Global.resources)
	
	queue_free()
