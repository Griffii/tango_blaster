extends CharacterBody2D

var bulletPath = preload("res://Scenes/bullet_01.tscn")

var is_clicking = false
var cooldown_time = 0.1
var current_cooldown = 0.0

### Process Function to check for changing variables
func _process(delta: float) -> void:
	# If mouse is clicking, fire away!
	# Cooldown timer controls the BRRRRR
	if is_clicking:
		current_cooldown -= delta
		if current_cooldown <= 0.0:
			shoot()
			# Reset the cool down after action
			current_cooldown = cooldown_time

# On collision, reduce health
func _on_area_2d_area_entered(area: Area2D) -> void:
	#Check what collided and set damage accordingly
	var damage
	if area.is_in_group("projectile"):
		damage = 0 # No friendly fire
	else:
		damage = area.get_damage()
		# Decrease player health 
		if Global.player_health > 0:
			Global.player_health -= damage
		else:
			player_death()

# Input event - mouse click called when mouse is clicked or released
func _input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.is_pressed():
			is_clicking = true
		else:
			is_clicking = false

# Spawn a bullet 
func shoot():
	var bullet = bulletPath.instantiate()
	bullet.position = Vector2(0,167) # Position
	bullet.bullet_direction = (position - get_global_mouse_position()).normalized()
	get_parent().add_child(bullet)


# Player death function
func player_death():
	print("YOU DIED")
	print(Global.resources)
	
	Global.is_game_paused = true
	## Pause or main menu or whatever
