extends Area2D

@onready var player = get_parent().get_node("Player")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if !player.is_had_package and self.has_overlapping_bodies() and Input.is_action_just_pressed("pickup"):
		player.is_had_package = true
		player.grab_package()
		print("picking up")



