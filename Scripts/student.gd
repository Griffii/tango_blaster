extends CharacterBody2D

var bulletPath = preload("res://Scenes/bullet_01.tscn")


# On collision, reduce health
func _on_area_2d_area_entered(area: Area2D) -> void:
	# Decrease player health 
	Global.player_health -= 1
	

# Input event - mouse click
func _input(event):
	if event.is_action_pressed("click"):
		print("pew")
		shoot()

# Spawn a bullet at a location
func shoot():
	var bullet = bulletPath.instantiate()
	get_parent().add_child(bullet)
	# Position
	bullet.position = Vector2(0,169)
