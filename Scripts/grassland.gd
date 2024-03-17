extends Area2D

var current_map_coords

@onready var _31x_31 = $"31x31"
const treenode = preload("res://Scenes/tree.tscn")
var already_have = false

var trees_in_map = {}


func _ready():
	var have_grass = _31x_31.get_used_cells(0)
	if WorldSave.verify_map_exist(current_map_coords):
		for grass_cell in have_grass:
			if WorldSave.retrieve_tree_data(current_map_coords, grass_cell):
				load_trees(grass_cell)
		
	else:
		for grass_cell in have_grass:
			generate_trees(grass_cell)
		WorldSave.add_tree(current_map_coords, trees_in_map)

func save_position(coords):
	current_map_coords = coords

func generate_trees(cell):
	var tree_or_not = randi_range(0,50)
	if tree_or_not == 1:
		var tree = treenode.instantiate()
		tree.tree_coord = cell
		tree.tree_map_coord = current_map_coords
		trees_in_map[cell] = true
		tree.set_position(cell * 16)
		add_child(tree)

func load_trees(cell):
	var tree = treenode.instantiate()
	tree.tree_coord = cell
	tree.tree_map_coord = current_map_coords
	tree.set_position(cell * 16)
	add_child(tree)
