extends Sprite2D

@onready var grab: Node2D = $"../../Player/GrabPosition"
var box_index := 0
# Called when the node enters the scene tree for the first time.
func _ready():
	set_physics_process(false)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	self.global_position = grab.global_position
