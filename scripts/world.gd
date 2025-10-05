extends WorldEnvironment

var atk_played: bool = false

const SOUND_DELAY = 2.5
const SOUND_CHANCE = 0.05

var sound_timer := SOUND_DELAY

func _ready() -> void:
    AudioManager.play("res://assets/ambient_wind.wav", 0)

func jumpscare():
    $"Player".process_mode = Node.PROCESS_MODE_DISABLED
    $"Player/jumpscarr".visible = true
    AudioManager.play("res://assets/death.wav")

func _process(delta: float) -> void:
    sound_timer -= delta
    if sound_timer <= 0.0:
        sound_timer = SOUND_DELAY
        if randf() <= SOUND_CHANCE:
            AudioManager.play("res://assets/ambient.wav")
    
    if ($"Player/jumpscarr".visible != true):
        return
    if !atk_played:
        atk_played = true
        AudioManager.play("res://assets/ambient_wind.wav", 0)
        
    print($"Player/jumpscarr".position.z)
    if ($"Player/jumpscarr".position.z < -0.25):
        $"Player/jumpscarr".position.z += delta*2
        $"Player/jumpscarr".rotation.z += delta * -0.3
