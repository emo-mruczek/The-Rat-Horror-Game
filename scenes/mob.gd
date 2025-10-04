extends CharacterBody3D


const SPEED = 1


func _physics_process(delta: float) -> void:
    # Add the gravity.
    if not is_on_floor():
        velocity += get_gravity() * delta
    
    var targetPosition: Vector3
    
    var player: Player = get_tree().get_first_node_in_group("player")
    if player != null:
        targetPosition = player.position
    else:
        targetPosition = Vector3(0,0,0)

    var direction = global_position.direction_to(player.global_position)
    print("Direction to player:", direction)
    velocity.x = direction.x * SPEED
    velocity.z = direction.z * SPEED

    move_and_slide()
