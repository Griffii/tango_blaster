extends AnimatableBody2D

var kana = ""
var reading = ""
var level = 6
var health = 1
var damage = 1
var speed = 100


# Remove sprite when collided
func _on_area_2d_area_entered(area: Area2D) -> void:
	# Check what it collided with, if player or projectile despawn
	if area.is_in_group("student") or area.is_in_group("projectile"):
		despawn()
		
	

# Deletes the node
func despawn():
	# play animation
	queue_free()
