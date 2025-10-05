class_name Player

extends CharacterBody3D
@onready var holds_camera: bool = true
signal flashlight_clicked

@export
var holding_item = "flashlight"
var has_flashlight = true

const SPEED = 3.0
const JUMP_VELOCITY = 4.5
const MOUSE_SENSITIVITY = 0.002
const PITCH_MAX_DEGREES = 89
const STEP_DELAY = 0.25
const SCRATCH_DELAY = 0.4
const SCRATCH_CHANCE = 0.05

var step_timer := STEP_DELAY
var scratch_timer := SCRATCH_DELAY
var scratch_amount := 0

@onready var items = [
    ["flashlight", $"player-flashlight", preload("res://scenes/flashlight_item.tscn")],
    ["key_1", $"player-key-1", preload("res://scenes/key_1.tscn")],
]
func _ready() -> void:
    Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
    $Timer.start()

func _input(event: InputEvent) -> void:
    if event is InputEventMouseMotion and Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
        rotate_y(-event.relative.x * MOUSE_SENSITIVITY)
        #$Camera3D.rotate_x(-event.relative.y * MOUSE_SENSITIVITY)
        #$Camera3D.rotation.x = clampf($Camera3D.rotation.x, -deg_to_rad(PITCH_MAX_DEGREES), deg_to_rad(PITCH_MAX_DEGREES))

func _process(_delta: float) -> void:
    if Input.is_action_just_pressed("drop"):
            drop_item(holding_item)


func drop_item(old_name: String) -> bool:
    if $Timer.time_left != 0:
        return false
    
    if holding_item == "":
        return true
    $Timer.start()
    for i in items:
        if i[0] == old_name:
            holding_item = ""
            i[1].set_process(false)
            i[1].hide()
            if old_name == "flashlight":
                $"player-flashlight/Area3D".monitoring = false
            var pickable_item = i[2].instantiate()
            get_parent().add_child(pickable_item)
            pickable_item.set("position", position)
            pickable_item.set("rotation", rotation)
            return true
    return true
    
func try_pick_item(new_name: String) -> bool:
    print(new_name)
    var res = drop_item(holding_item)
    if !res:
        return false
    for i in items:
        if i[0] == new_name:
            if new_name == "flashlight":
                $"player-flashlight/Area3D".monitoring = true
            print(new_name)
            i[1].set_process(true)
            i[1].show()
            holding_item = i[0]
            return true
    return true
            
func _physics_process(delta: float) -> void:
    
    if Input.is_action_pressed("yaw_right"):
        rotate_y(-2*delta)
    if Input.is_action_pressed("yaw_left"):
        rotate_y(2*delta)
    # Add the gravity.
    if not is_on_floor():
        velocity += get_gravity() * delta

    # Handle jump.
    #if Input.is_action_just_pressed("ui_accept") and is_on_floor():
    #    velocity.y = JUMP_VELOCITY

    if Input.is_action_just_pressed("flashlight"):
        if holding_item != "flashlight":
            return
        has_flashlight = not has_flashlight
        flashlight_clicked.emit()

    scratch_timer -= delta
    if scratch_timer <= 0.0:
        scratch_timer = SCRATCH_DELAY
        if scratch_amount > 0:
            scratch_amount -= 1
            AudioManager.play("res://assets/scratching.wav")
        elif randf() <= SCRATCH_CHANCE:
            scratch_amount = randi_range(0, 4)
            AudioManager.play("res://assets/scratching.wav")

    # Get the input direction and handle the movement/deceleration.
    # As good practice, you should replace UI actions with custom gameplay actions.
    var input_dir := Input.get_vector("move_left", "move_right", "move_forward", "move_back")
    var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
    if direction:
        velocity.x = direction.x * SPEED
        velocity.z = direction.z * SPEED

        step_timer -= delta
        if step_timer <= 0.0:
            step_timer = STEP_DELAY
            AudioManager.play("res://assets/step.wav")
    else:
        velocity.x = move_toward(velocity.x, 0, SPEED)
        velocity.z = move_toward(velocity.z, 0, SPEED)

    move_and_slide()
