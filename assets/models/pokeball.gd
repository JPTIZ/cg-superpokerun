extends Spatial

# Declare member variables here. Examples:
var time = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
    time += PI / 60

    rotate_y(deg2rad(45 * delta))
    translate(Vector3(0, sin(time) * delta, 0))

func _on_Item1_body_entered(body: Node) -> void:
    if body is KinematicBody:
        queue_free()