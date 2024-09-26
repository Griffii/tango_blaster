extends Area2D

var id = ""
var kana = ""
var reading = ""
var health = 1
var damage = 1
var speed = 150

func set_kana(new_kana: String):
	kana = new_kana
func get_kana() -> String:
	return kana

func set_reading(new_reading: String):
	reading = new_reading
func get_reading() -> String:
	return reading

func set_id(new_id: String):
	id = new_id
func get_id() -> String:
	return id

func get_damage() -> int:
	return damage
func get_health() -> int:
	return health
func get_speed() -> int:
	return speed

#DEBUG Function to print all stored data in a doctionary format
func print_data():
	print(id, ", ", kana, ", ", reading, ", ", health, ", ", damage, ", ", speed)

# Remove sprite when collided with Player
func _on_area_entered(area: Area2D) -> void:
	# Check what it collided with, if player despawn
	if area.is_in_group("student"):
		despawn()

# Function to take damage
func take_damage(damage_amount: int):
	health =- damage_amount
	if health <= 0:
		despawn()


# Deletes the node and removes it from tracking array
func despawn():
	# Check ID and remove from global array of spawned sprites
	Global.remove_dict_by_id(id)
	##print("Destroyed: ", id)
	
	# Check health, if 0 the sprite was destroyed and should award points to the player
	##Maybe this should have a seperate function, but this works for now
	if health <= 0:
		Global.resources["n6_cards"] += 1
		##print(Global.resources)
	
	queue_free()
