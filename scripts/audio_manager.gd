extends Node

var num_players = 8
var bus = "master"

var available = []
var queue = []

func _ready() -> void:
    for i in num_players:
        var player = AudioStreamPlayer.new()
        add_child(player)
        available.append(player)
        
        player.bus = bus

func _on_stream_finished(stream: AudioStreamPlayer, loop: bool) -> void:
    if loop:
        stream.play()
    else:
        available.append(stream)

func play(sound_path: String, loop: bool = false) -> void:
    queue.append({ "path": sound_path, "loop": loop })

func _process(delta: float) -> void:
    if not queue.is_empty() and not available.is_empty():
        var sound = queue.pop_front()
        available[0].stream = load(sound.path)
        available[0].finished.connect(_on_stream_finished.bind(available[0], sound.loop))
        available[0].play()
        available.pop_front()
