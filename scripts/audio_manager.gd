extends Node

var num_players = 16
var bus = "master"

var infinite_loops: Array[Dictionary] = []
var finite_loops: Array[Dictionary] = []

var available = []

func _ready() -> void:
    for i in num_players:
        var player = AudioStreamPlayer.new()
        add_child(player)
        available.append(player)
        
        player.bus = bus

func _on_stream_finished(stream: AudioStreamPlayer, sound: Dictionary, finite: bool) -> void:
    stream.finished.disconnect(_on_stream_finished)
    available.append(stream)
    if finite:
        sound.times -= 1
        if sound.times > 0:
            finite_loops.append(sound)
    else:
        infinite_loops.append(sound)

# if times is 0 the loop is infinite
func play(sound_path: String, times: int = 1, delay: float = 0.0) -> void:
    if times == 0:
        infinite_loops.append({
            "path": sound_path,
            "delay": delay,
            "timer": 0,
        })
    else:
        finite_loops.append({
            "path": sound_path,
            "times": times,
            "delay": delay,
            "timer": 0,
        })
        
func _play_sound(sound: Dictionary, finite: bool) -> void:
    if not available.is_empty():
        available[0].stream = load(sound.path)
        available[0].finished.connect(_on_stream_finished.bind(available[0], sound, finite))
        available[0].play()
        available.pop_front()    

func _process(delta: float) -> void:
    for sound in infinite_loops:
        sound.timer -= delta
        if sound.timer <= 0.0:
            sound.timer = sound.delay
            _play_sound(sound, false)
    
    infinite_loops.clear()

    for sound in finite_loops:
        sound.timer -= delta
        if sound.timer <= 0.0:
            sound.timer = sound.delay
            _play_sound(sound, true)
                
    finite_loops.clear()
