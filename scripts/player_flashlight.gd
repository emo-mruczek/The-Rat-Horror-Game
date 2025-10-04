extends Node


func _on_player_flashlight_clicked() -> void:
    $SpotLight3D.visible = not $SpotLight3D.visible
    $FlashlightLight.visible = not $FlashlightLight.visible
    AudioManager.play("res://assets/flashlight.wav")

func _on_area_3d_body_entered(body: Node3D) -> void:
    if $SpotLight3D.visible and body.is_in_group("mob"):
        var enemy: Mob = body
        enemy.stop_in_light()

func _on_area_3d_body_exited(body: Node3D) -> void:
    if $SpotLight3D.visible and body.is_in_group("mob"):
        var enemy: Mob = body
        enemy.move_in_dark()
