extends KinematicBody

# Properties
const speed = 3000
const gravity = -9.8

var dir = Vector3(0, 0, 0)
var velocity = Vector3()


# Called when the node enters the scene tree for the first time.
func _ready():
    pass
    # $AnimationPlayer.play('Weird')


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
    dir = Vector3()

    if Input.is_action_pressed('ui_up'):
        dir.x += sin(rotation.y)
        dir.z += cos(rotation.y)
    elif Input.is_action_pressed('ui_down'):
        dir.x -= sin(rotation.y)
        dir.z -= cos(rotation.y)

    if Input.is_action_pressed('ui_left'):
        rotation.y += deg2rad(5)
    elif Input.is_action_pressed('ui_right'):
        rotation.y -= deg2rad(5)

    dir = dir.normalized() * speed * delta

    var _gravity = gravity * speed / 100

    velocity.y += _gravity * delta
    velocity.x = dir.x
    velocity.z = dir.z

    velocity = move_and_slide(velocity, Vector3(0, 1, 0))

    if is_on_floor() and Input.is_key_pressed(KEY_SPACE):
        velocity.y = -gravity * 10