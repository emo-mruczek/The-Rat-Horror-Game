extends Node

func _physics_process(_delta: float) -> void:
    if $Area3D.monitoring == true:
        $FlashlightLight.visible = true
        $SpotLight3D.visible = true
    
func _on_player_flashlight_clicked() -> void:
    $SpotLight3D.visible = not $SpotLight3D.visible
    $FlashlightLight.visible = not $FlashlightLight.visible
    AudioManager.play("res://assets/flashlight.wav")
    if !$SpotLight3D.visible:
        for e in $Area3D.get_overlapping_bodies():
            var enemy: Mob = e
            enemy.move_in_dark()
            $Area3D.monitoring = false
    else:
        for e in $Area3D.get_overlapping_bodies():
            var enemy: Mob = e
            enemy.stop_in_light()
            $Area3D.monitoring = true

func _on_area_3d_body_entered(body: Node3D) -> void:
    if $SpotLight3D.visible and body.is_in_group("mob"):
        var enemy: Mob = body
        enemy.stop_in_light()

func _on_area_3d_body_exited(body: Node3D) -> void:
    if body.is_in_group("mob"):
        var enemy: Mob = body
        enemy.move_in_dark()
