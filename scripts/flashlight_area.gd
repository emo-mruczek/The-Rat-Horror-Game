extends Area3D


func _physics_process(_delta: float) -> void:
    var bodies = get_overlapping_bodies()
    for body in bodies:
        if body.is_in_group("mob"):
            var mob: Mob = body
            mob.stop_in_light()
            
