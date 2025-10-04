extends CharacterBody3D


const SPEED = 1


func _physics_process(delta: float) -> void:
    # Add the gravity.
    if not is_on_floor():
        velocity += get_gravity() * delta
    
    
    var player: Player = get_tree().get_first_node_in_group("player")
    if player == null:
        return


    var direction = global_position.direction_to(player.global_position)
    
    if global_position.distance_to(player.global_position) < 1:
        return
    velocity.x = direction.x * SPEED
    velocity.z = direction.z * SPEED

    move_and_slide()
