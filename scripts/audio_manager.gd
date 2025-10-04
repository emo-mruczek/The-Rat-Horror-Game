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
        player.finished.connect(_on_stream_finished.bind(player))
        player.bus = bus

func _on_stream_finished(stream):
    available.append(stream)

func play(sound_path):
    queue.append(sound_path)

func _process(delta: float) -> void:
    if not queue.is_empty() and not available.is_empty():
        available[0].stream = load(queue.pop_front())
        available[0].play()
        available.pop_front()
