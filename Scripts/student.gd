extends CharacterBody2D

var bulletPath = preload("res://Scenes/bullet_01.tscn")


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

# Input event - mouse click
func _input(event):
	if event.is_action_pressed("click"):
		shoot()

# Spawn a bullet 
func shoot():
	var bullet = bulletPath.instantiate()
	bullet.position = Vector2(0,169)  # Position
	bullet.bullet_direction = (position - get_global_mouse_position()).normalized()
	get_parent().add_child(bullet)

# Player death function
func player_death():
	print("YOU DIED")
	print(Global.resources)
	
	Global.is_game_paused = true
	## Pause or main menu or whatever
