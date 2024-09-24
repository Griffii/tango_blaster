extends CharacterBody2D

var bulletPath = preload("res://Scenes/bullet_01.tscn")


# On collision, reduce health
func _on_area_2d_area_entered(area: Area2D) -> void:
	var damage
	#Check what collided and set damage accordingly
	if area.is_in_group("N6"):
		damage = 1
	if area.is_in_group("projectile"):
		damage = 0
	
	# Decrease player health 
	if Global.player_health > 0:
		Global.player_health -= damage

# Input event - mouse click
func _input(event):
	if event.is_action_pressed("click"):
		shoot()

# Spawn a bullet 
func shoot():
	var bullet = bulletPath.instantiate()
	# Position
	bullet.position = Vector2(0,169)
	bullet.bullet_direction = (position - get_global_mouse_position()).normalized()
	get_parent().add_child(bullet)
