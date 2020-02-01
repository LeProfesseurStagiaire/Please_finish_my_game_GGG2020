extends Node2D

var enemi
onready var wave_selected
onready var death_marker = preload("res://player/death_mark.tscn")
onready var wave_exp = preload("res://player/wave_explosion.tscn").instance()
onready var scene_end = preload("res://end_scene.tscn")
var spawn_timer = 1
#var game_runing = false
var game_endend = false

var type_enemi_nb = [1,2,3,4]
var enemi_rand_tex = [null]
var enemi_loaded_scene = [null]

var shake_time = 0 
var shake_force = Vector2()

signal game_run
signal game_stop

func _ready():
	if !music_singleton.get_node("audio").playing:
		rand_sound(get_node("/root/music_singleton/audio"),"audio/m",2)
	$player/Sprite.texture = make_image("user://missile_assets/player")
	for x in type_enemi_nb:
		enemi_rand_tex.append(make_image("user://missile_assets/output"))
	if global.wave_unlocked_this_turn:
		wave_selected = global.wave_unlocked
	else:
		wave_selected = global.wave_selected
		if global.wave_win_this_turn:
			wave_selected +=1
	global.wave_unlocked_this_turn = false
	global.wave_win_this_turn = false
	draw_menu()
	$Timer.start(1)
	$start_txt/wave_selected_text.text = "WAVE : "+str(wave_selected)
	if global.game_runing:
		game_start()

func _process(delta):
	if !music_singleton.get_node("audio").playing:
		rand_sound(get_node("/root/music_singleton/audio"),"audio/m",2)
	if shake_time > 0:
		$Camera2D.offset = Vector2(rand_range(2,10),rand_range(2,10))
		shake_time -= 1 * delta
	else:
		$Camera2D.offset = Vector2(0,0)

func _input(event):
	if global.game_runing == false && game_endend == false:
		if Input.is_action_just_pressed("scroll_down"):
			if wave_selected > 1 :
				wave_selected -= 1
				shake_time = 0.08
		if Input.is_action_just_pressed("scroll_up"):
			if wave_selected < global.wave_unlocked:
				wave_selected += 1
				shake_time = 0.08
		draw_menu()
	if Input.is_action_just_pressed("play"):
		if global.game_runing == false && game_endend == false:
			game_start()
		if global.game_runing == false && game_endend == true:
			if global.wave_unlocked > global.wave.size():
				get_tree().change_scene_to(scene_end)
			else:
				get_tree().reload_current_scene()
				global.game_runing = true
	if Input.is_action_just_pressed("right_click"):
		if global.game_runing == false && game_endend == true:
			get_tree().reload_current_scene()
			global.game_runing = false

func game_start():
	for x in type_enemi_nb:
		enemi_loaded_scene.append(load("res://enemi/enemi_type_" +str(x)+".tscn"))
	AudioServer.set_bus_effect_enabled(1,0,0)
	global.wave_selected = wave_selected
	global.game_runing = true
	$start_txt/wave_selected_text.hide()
	$start_txt/left.hide()
	$start_txt/scroll.hide()
	$start_txt/right.hide()
	emit_signal("game_run")

func draw_menu():
	$start_txt/wave_selected_text.text = "VAGUE : "+str(wave_selected)
	if global.wave.get("wave_"+str(wave_selected)).get("param").has("color"):
		$color/ColorRect.color = global.wave.get("wave_"+str(wave_selected)).get("param").get("color")
	else :
		$color/ColorRect.color = Color(0.192157, 0.192157, 0.192157)
	if global.wave.get("wave_"+str(wave_selected)).get("param").has("scale"):
		$Sprite.scale = global.wave.get("wave_"+str(wave_selected)).get("param").get("scale")
	else :
		$Sprite.scale = Vector2(1,1)

func game_stop():
	emit_signal("game_stop",false)
	game_ended(false)
	wave_exp.position = Vector2(get_viewport_rect().size.x /2 ,get_viewport_rect().size.x/2)
	add_child(wave_exp)

func player_death(p):
	shake_time = 0.2
	emit_signal("game_stop",true)
	game_ended(true)
	var m = death_marker.instance()
	m.position = p
	call_deferred("add_child",m)

func game_ended(loose):
	if !loose:
		rand_sound($sounds/player_win_level,"sound/win/w",1)
		$sounds/player_win_level.play()
		$start_txt/left/left_click.text = "Niveau suivant"
		$start_txt/left.show()
	else:
		rand_sound($sounds/player_death,"sound/death/d",2)
		$sounds/player_death.play()
		$start_txt/left/left_click.text = "Rejouer"
		$start_txt/right/right_click.text = "Retour"
		$start_txt/right.show()
		$start_txt/left.show()
	AudioServer.set_bus_effect_enabled(1,0,1)
	$Timer.stop()
	global.game_runing = false
	game_endend = true

func _on_Timer_timeout():
	if global.game_runing == true :
		var rand_enemi_type = global.wave.get("wave_"+str(wave_selected)).get("Etype")[rand_range(0,global.wave.get("wave_"+str(wave_selected)).get("Etype").size())]
		randomize()
		var spawn_position = int(rand_range(0,3))
		var rand_pos = get_viewport_rect().size.x - rand_range(0,get_viewport_rect().size.x)
		var pos = Vector2()
		if spawn_position == 0 :
			pos = Vector2(rand_pos, 0)
		if spawn_position == 1 :
			pos = Vector2(0, rand_pos)
		if spawn_position == 2 :
			pos = Vector2(get_viewport_rect().size.x, rand_pos)
		if spawn_position == 3 :
			pos = Vector2(rand_pos, get_viewport_rect().size.x)
#		enemi = load("res://enemi/enemi_type_" +str(rand_enemi_type)+".tscn")
		enemi = enemi_loaded_scene[rand_enemi_type]
		var spawn = enemi.instance()
		if global.wave.get("wave_"+str(wave_selected)).get("Ecarac").has(rand_enemi_type):
			for x in global.caract_list:
				if global.wave.get("wave_"+str(wave_selected)).get("Ecarac").get(rand_enemi_type).has(x):
					spawn.set(x,rand_range(global.wave.get("wave_"+str(wave_selected)).get("Ecarac").get(rand_enemi_type).get(x).x,
					global.wave.get("wave_"+str(wave_selected)).get("Ecarac").get(rand_enemi_type).get(x).y))
		spawn.position = pos
		if enemi_rand_tex[rand_enemi_type]:
			spawn.get_node("Sprite").texture = enemi_rand_tex[rand_enemi_type]
		add_child(spawn)
		$Timer.start(spawn.next_spawn_time)

func make_image(path):
	var tex = ImageTexture.new()
	var img = Image.new()
	if random_texture(path):
		img.load(random_texture(path))
		tex.create_from_image(img)
		return tex
	return null

# loaded texture are here : C:\Users\Ange\AppData\Roaming\Godot\app_userdata\missile\missile_assets

func random_texture(path):
	var d = Directory.new()
	if !(d.dir_exists("user://missile_assets")):
		print("ERR: dir does not exist ")
		d.open("user://")
		d.make_dir("user://missile_assets")
	randomize()
	var file_name
	var files = []
	var dir = Directory.new()
	var error = dir.open(path)
	if error!=OK:
		print("Can't open "+path+"!")
		return
	dir.list_dir_begin(true)
	file_name = dir.get_next()
	while file_name!="":
		if dir.current_is_dir():
			var new_path = path+"/"+file_name
			print("Found directory "+new_path+".")
			files += random_texture(new_path)
		else:
			var name = path+"/"+file_name
			files.push_back(name)
		file_name = dir.get_next()
	if files:
		return files[randi()%files.size()]
	dir.list_dir_end()

func rand_sound(node,path,nb_sound):
	randomize()
#	var file_name
#	var files = []
#	var dir = Directory.new()
#	dir.open("res://assets/"+path)
#	dir.list_dir_begin(true)
#	file_name = dir.get_next()
#	while file_name!="":
#		if file_name.ends_with("wav"):
#			if dir.current_is_dir():
#				var new_path = "res://assets/"+path+"/"+file_name
#				print("Found directory "+new_path+".")
#			else:
#				var name = "res://assets/"+path+"/"+file_name
#				files.push_back(name)
#		file_name = dir.get_next()
#	node.stream = load(files[randi()%files.size()])
	node.stream = load("res://assets/"+str(path)+str(int(rand_range(1,nb_sound+1)))+".wav")
	node.play()
#	dir.list_dir_end()