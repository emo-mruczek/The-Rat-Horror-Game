class_name PickableBody
extends RigidBody3D

@export var area: Area3D
@export var signal_name: String = "item_name"
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta: float) -> void:
    if Input.is_action_just_pressed("interact"):
        var bodies = area.get_overlapping_bodies()
        for body in bodies:
            if body.is_in_group("player"):
                var player: Player = body
                var res = player.try_pick_item(signal_name)
                if res:    
                    queue_free()
           
