extends Spatial

# Declare member variables here. Examples:
var finished = false
var countdown = 3
var state = funcref(self, 'initial_state')
var main_alert


func try_or_fail(err: int) -> void:
    if err != 0:
        printerr(err)


func _ready() -> void:
#    $Pikachu.enabled = false
    $water/WaterAnimPlayer.set_current_animation('water_anim')
    $water/WaterAnimPlayer.play()
    try_or_fail($timer.connect('timeout', self, 'reduce_countdown'))
    $timer.set_wait_time(1)
    $timer.start()
    main_alert = $HUD.get_node('main-alert')
    main_alert.set_text(str(countdown))


func reduce_countdown():
    countdown -= 1
    if not finished:
        main_alert.set_text(str(countdown))


func _process(delta: float) -> void:
    if Input.is_action_just_pressed('ui_accept'):
        try_or_fail(get_tree().reload_current_scene())

    state.call_func(delta)


func _on_Checkpoint_body_entered(body: Node) -> void:
    if body == $Pikachu:
        main_alert.set_text('You Win!')
        main_alert.show()
        finished = true
        $Pikachu.enabled = false
        $music.stream = load('res://assets/audio/music/super-mario-kart-race-finale.ogg')
        $music.play()


# warning-ignore:unused_argument
func initial_state(delta: float) -> void:
    if countdown == 0:
        try_or_fail($timer.connect('timeout', self, 'hide_panel'))
        main_alert.set_text('Go!')
        $Pikachu.enabled = true
        state = funcref(self, 'on_game_update')
        $music.stream = load('res://assets/audio/music/super-mario-kart-mario-circuit.ogg')
        $music.play()


func hide_panel() -> void:
    if not finished:
        main_alert.hide()
    $timer.stop()


# warning-ignore:unused_argument
func on_game_update(delta: float) -> void:
    if $Pikachu.dead and main_alert.visible == false:
        main_alert.set_text('You Lost!')
        main_alert.show()