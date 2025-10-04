extends Node

func _on_player_flashlight_clicked() -> void:
    var player = get_tree().get_first_node_in_group("player")
    if player.has_flashlight:
        $SpotLight3D.visible = true
    else:
        $SpotLight3D.visible = false


func _on_area_3d_body_entered(body: Node3D) -> void:
    print("enter")
    if body.is_in_group("mob"):
        print("is mob")
        var enemy: Mob = body
        enemy.stop_in_light()


func _on_area_3d_body_exited(body: Node3D) -> void:
    if body.is_in_group("mob"):
        var enemy: Mob = body
        enemy.move_in_dark()
