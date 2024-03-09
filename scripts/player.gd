extends CharacterBody2D


const SPEED = 300.0

@onready var packages: Array = self.get_parent().get_node("Packages").get_children()
var is_had_package := false
var grabbed_package = null

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
	var direction = Input.get_axis("left", "right")
	
	if Input.is_action_just_pressed("left"):
		$Sprite2D.set_flip_h(true)
	elif Input.is_action_just_pressed("right"):
		$Sprite2D.set_flip_h(false)
	
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

func grab_package():
	if packages.size() == 0:
		return
	grabbed_package = packages.pick_random()
	packages.erase(grabbed_package)
	var tween = create_tween()
	tween.tween_property(grabbed_package, "global_position", $GrabPosition.global_position, 0.3)
	await tween.finished
	grabbed_package.set_physics_process(true)
	#print(grabbed_package.box_index)
