extends Node

const key_id = "key_1"

func _on_area_3d_body_entered(body: Node3D) -> void:
    if body.is_in_group("player"):
        var player: Player = body
        if player.holding_item == key_id:
            queue_free()
        

func _on_area_3d_body_exited(body: Node3D) -> void:
    if body.is_in_group("player"):
        var player: Player = body
        print("pupa")
