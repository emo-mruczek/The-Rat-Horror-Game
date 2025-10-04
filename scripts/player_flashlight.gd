extends Node

func _on_player_flashlight_clicked() -> void:
    var player = get_tree().get_first_node_in_group("player")
    if player.has_flashlight:
        $SpotLight3D.visible = true
    else:
        $SpotLight3D.visible = false
