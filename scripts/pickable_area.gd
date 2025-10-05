class_name PickableItem

extends Node3D


@export
var NAME: String

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta: float) -> void:
    return
    var bodies: Array[Node3D] = $ReachArea.get_overlapping_bodies()
    if bodies.size() > 0:
        $Label3D.visible = true
    else:
        $Label3D.visible = false
        

func ass() -> void:
    pass
