extends Area2D

var speed = 500
var despawn_range = 1000
var travelled_distance = 0
var bullet_direction

var bullet_damage = 1

func _physics_process(delta):
	position -= bullet_direction * speed * delta
	# Track distance to despawn after leaving screen
	travelled_distance += speed * delta
	if travelled_distance > despawn_range:
		queue_free()


#func _on_body_entered(body: Node2D) -> void:
	#print(body)
	##if body.has_method("take_damage"):  # Check if the body has the take_damage() method
	#body.take_damage(bullet_damage)  # Apply damage to the enemy
	#print("Hit body with ID:", body.id)  # Access enemy's ID
	#despawn()  # Destroy the projectile after hitting the enemy

func _on_area_entered(area: Area2D) -> void:
	if area.has_method("take_damage"):  # Check if the body has the take_damage() method
		##print("Hit area with ID:", area.id)  # Access enemy's ID
		area.take_damage(bullet_damage)  # Apply damage to the enemy
		despawn()  # Destroy the projectile after hitting the enemy


# Deletes the node
func despawn():
	# play animation
	queue_free()
