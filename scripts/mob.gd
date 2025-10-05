class_name Mob

extends CharacterBody3D

const SPEED = 3
const STEP_DELAY = 0.2

var can_move = true
var in_flashlight_range = false
var step_timer = 0
var audio = AudioStreamPlayer3D.new()

func _ready() -> void:
    audio.stream = load("res://assets/enemystep.wav")
    add_child(audio)

func _physics_process(delta: float) -> void:
    # Add the gravity.
    if not is_on_floor():
        velocity += get_gravity() * delta
        
    if !can_move:
        velocity.x = 0
        velocity.z = 0
        move_and_slide()
        return
    
    var player: Player = get_tree().get_first_node_in_group("player")
    if player == null:
        return

    var direction = global_position.direction_to(player.global_position)
    
    if global_position.distance_to(player.global_position) > 15:
        return
    velocity.x = direction.x * SPEED
    velocity.z = direction.z * SPEED

    move_and_slide()

    step_timer -= delta
    if step_timer <= 0.0:
        step_timer = STEP_DELAY
        audio.play()

func stop_in_light():
    can_move = false
    in_flashlight_range = true
    
func move_in_dark():
    can_move = true
    in_flashlight_range = false
    
func _on_player_flashlight_clicked() -> void:
    if in_flashlight_range:
        can_move = not can_move


func _on_jumpscare_range_body_entered(body: Node3D) -> void:
    if body.is_in_group("player"):
        get_node("/root/World").jumpscare()
