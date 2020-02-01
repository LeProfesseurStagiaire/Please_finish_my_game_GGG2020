extends Node2D

func _ready():
	rand_soung()

func rand_soung():
	randomize()
	var file_name
	var files = []
	var dir = Directory.new()
	dir.open("res://assets/audio/")
	dir.list_dir_begin(true)
	file_name = dir.get_next()
	while file_name!="":
		if file_name.ends_with("wav"):
			if dir.current_is_dir():
				var new_path = "res://assets/audio/"+file_name
				print("Found directory "+new_path+".")
			else:
				var name = "res://assets/audio/"+file_name
				files.push_back(name)
		file_name = dir.get_next()
	$AudioStreamPlayer.stream = load(files[randi()%files.size()])
	$AudioStreamPlayer.play()
	dir.list_dir_end()

func _on_AudioStreamPlayer_finished():
	rand_soung()
