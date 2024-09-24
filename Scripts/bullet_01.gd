extends Area2D

var speed = 500
var despawn_range = 1000
var travelled_distance = 0
var bullet_direction

func _physics_process(delta):
	
	position -= bullet_direction * speed * delta
	
	# Track distance to despawn after leaving screen
	travelled_distance += speed * delta
	if travelled_distance > despawn_range:
		queue_free()

func _on_area_entered(area: Area2D) -> void:
	despawn()

# Deletes the node
func despawn():
	# play animation
	queue_free()
