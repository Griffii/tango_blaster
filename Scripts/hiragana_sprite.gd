extends AnimatableBody2D


# var id : int = 0
var type = 6

var health = 1
var damage = 1
var speed = 100



# Remove sprite when collided
func _on_area_2d_area_entered(area: Area2D) -> void:
	# Check what it collided with, if player despawn
	if area.is_in_group("student"):
		despawn()
		Global.sprite_array_type.erase(type)


# Deletes the node
func despawn():
	queue_free()
