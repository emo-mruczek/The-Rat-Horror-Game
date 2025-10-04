extends Node

func _process(_delta: float) -> void:
    var playerArray: Player = get_tree().get_first_node_in_group("player")
    if playerArray == null:
        return       
    if playerArray.has_flashlight:
        $SpotLight3D.visible = true
    else:
        $SpotLight3D.visible = false
