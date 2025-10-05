extends PickableBody


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	area = $PickableArea
	$PlayerKey2.set("shaded", true)
	$PlayerKey2.set("modulate", Color(1,1,1,1))
