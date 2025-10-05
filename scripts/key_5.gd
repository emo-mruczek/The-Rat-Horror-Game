extends PickableBody


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    area = $PickableArea
    $PlayerKey5.set("shaded", true)
    $PlayerKey5.set("modulate", Color(1,1,1,1))
