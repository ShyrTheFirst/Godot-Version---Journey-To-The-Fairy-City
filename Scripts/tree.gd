extends StaticBody2D

@export var health = 1
@export var wood_quant = 1
@export var wood_type = 'normal' #change this to match selection type of data
var tree_coord = Vector2()
var tree_map_coord = Vector2()

var enemy_scene = preload("res://Scenes/enemy.tscn")
const object_scene = preload("res://Scenes/objeto.tscn")

func _on_hitbox_area_entered(area):
	if area.name == 'PlayerAttackArea':
		#animated damage
		health -= PlayerVar.damage
		if health <= 0:
			#Create enemy or only give wood - create a random event here to define if enemy will be created
			var mob_or_not = randi_range(0,1)
			if mob_or_not == 1:
				var instance_enemy = enemy_scene.instantiate()
				instance_enemy.set_position(position)
				$"..".add_child(instance_enemy)
			
			#Create wood on ground
			for i in wood_quant:
				var instance_wood = object_scene.instantiate()
				#instance_wood.type = define type of wood here, based on type of tree
				var wood_pos = position + Vector2(randi_range(1,10)*i,randi_range(1,10)*i)
				instance_wood.set_position(wood_pos)
				$"..".add_child(instance_wood)
			
			WorldSave.kill_tree(tree_coord, tree_map_coord)
			queue_free()
