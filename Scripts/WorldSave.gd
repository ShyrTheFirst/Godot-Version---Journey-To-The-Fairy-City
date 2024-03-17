extends Node

var loaded_coords = []
var data_in_chunk = []
var maps_info = {}

func _ready():
	var test_coords = [Vector2(-1,3),Vector2(0,3),Vector2(1,3),Vector2(-1,4),Vector2(0,4),Vector2(1,4)]
	for coord in test_coords:
		loaded_coords.append(coord)
		data_in_chunk.append(2)
	#Create here the cities using the same preset as test_coords:
	#Initial City
	# -> city walls 
	#var test_coords = [Vector2(-1,3),Vector2(0,3),Vector2(1,3),Vector2(-1,4),Vector2(0,4),Vector2(1,4)]
	#for coord in test_coords:
		#loaded_coords.append(coord)
		#data_in_chunk.append(2)
	# -> city inner
	#var test_coords = [Vector2(-1,3),Vector2(0,3),Vector2(1,3),Vector2(-1,4),Vector2(0,4),Vector2(1,4)]
	#for coord in test_coords:
		#loaded_coords.append(coord)
		#data_in_chunk.append(3)
	
	#Military base City
	# -> city walls 
	#var test_coords = [Vector2(-1,3),Vector2(0,3),Vector2(1,3),Vector2(-1,4),Vector2(0,4),Vector2(1,4)]
	#for coord in test_coords:
		#loaded_coords.append(coord)
		#data_in_chunk.append(2)
	# -> city inner
	#var test_coords = [Vector2(-1,3),Vector2(0,3),Vector2(1,3),Vector2(-1,4),Vector2(0,4),Vector2(1,4)]
	#for coord in test_coords:
		#loaded_coords.append(coord)
		#data_in_chunk.append(4)
	
	#Fairy City:
	# -> city walls 
	#var test_coords = [Vector2(-1,3),Vector2(0,3),Vector2(1,3),Vector2(-1,4),Vector2(0,4),Vector2(1,4)]
	#for coord in test_coords:
		#loaded_coords.append(coord)
		#data_in_chunk.append(2)
	# -> city inner
	#var test_coords = [Vector2(-1,3),Vector2(0,3),Vector2(1,3),Vector2(-1,4),Vector2(0,4),Vector2(1,4)]
	#for coord in test_coords:
		#loaded_coords.append(coord)
		#data_in_chunk.append(5)
	
	
	#define the empty space at the character's position
	maps_info[Vector2(0,0)] = {}


func add_chunk(coords,data):
	loaded_coords.append(coords)
	data_in_chunk.append(data)
	
func add_tree(map_coords, trees_in_map):
	maps_info[map_coords] = trees_in_map

func kill_tree(tree_coords, map_coords):
	for key in maps_info: #verifica todas as keys dentro do dict
		if key == map_coords: #verifica se alguma key bate com a coordenada do mapa que está verificando
			for key2 in maps_info[key]: #verifica todas as keys dentro do dict do mapa
				if key2 == tree_coords: #verifica se alguma key bate com a coordenada que está sendo verificada
					if maps_info[key][tree_coords]: #verifica se o valor é true
						maps_info[key][tree_coords] = false # se for true, muda para false para matar a arvore
						return

func retrive_data(coords):
	var data = data_in_chunk[loaded_coords.find(coords)]
	return data

func retrieve_tree_data(map_coords, tree_coords):
	for key in maps_info: #verifica todas as keys dentro do dict
		if key == map_coords: #verifica se alguma key bate com a coordenada do mapa que está verificando
			for key2 in maps_info[key]: #verifica todas as keys dentro do dict do mapa
				if key2 == tree_coords: #verifica se alguma key bate com a coordenada que está sendo verificada
					if maps_info[key][key2]: #verifica se a arvore está 'viva'
						return true
					else: #se estiver 'morta', sai do loop
						return false

func verify_map_exist(pos):
	for key in maps_info:
		if key == pos:
			return true
