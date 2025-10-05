extends WorldEnvironment

func _ready() -> void:
    AudioManager.play("res://assets/ambient_wind.wav", 0)

func _process(delta: float) -> void:
    pass
