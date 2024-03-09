extends Area2D

@onready var player = $"../../Player"
@export var box_index_recipient_want :int = 0

@export var correct_score := 100

#idle animation
#tween animation when item delivered

func _ready():
	pass

func _process(delta):
	if player.is_had_package and self.has_overlapping_bodies() and Input.is_action_just_pressed("pickup"):
		player.is_had_package = false
		delivery_transition()
		
		#print(player.grabbed_package)

func check_box():
	if player.grabbed_package.box_index == box_index_recipient_want:
		get_parent().get_parent().scoring.emit(correct_score)
		#print("Correct box delivered")
	else:
		get_parent().get_parent().scoring.emit(-correct_score)
		#print("Incorrect box delivered")
		

func delivery_transition():
	var tween = create_tween()
	tween.tween_property(player.grabbed_package, "global_position", $DeliveredPos.global_position, 0.6)
	await tween.finished
	player.grabbed_package.queue_free()
	check_box()
