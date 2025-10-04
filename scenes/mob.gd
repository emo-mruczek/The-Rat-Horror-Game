extends CharacterBody3D


const SPEED = 500

func _physics_process(delta: float) -> void:
    # Add the gravity.
    if not is_on_floor():
        velocity += get_gravity() * delta
    
    var targetPosition: Vector3
    
    var playerArray: Array[Node] = get_tree().get_nodes_in_group("player")
    if playerArray.size() > 0:
        targetPosition = playerArray[0].position
    else:
        targetPosition = Vector3(0,0,0)

    velocity.x = move_toward(position.x, targetPosition.x, SPEED*delta)
    velocity.z = move_toward(position.z, targetPosition.z, SPEED*delta)

    move_and_slide()
