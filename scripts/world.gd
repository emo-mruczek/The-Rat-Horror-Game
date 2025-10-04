extends WorldEnvironment

func _ready() -> void:
    AudioManager.play("res://assets/ambient_wind.wav", true)

func _process(delta: float) -> void:
    pass
