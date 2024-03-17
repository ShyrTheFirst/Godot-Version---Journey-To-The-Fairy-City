extends Area2D
	
func _on_body_entered(body):
	if body.name == "Player":
		#add item to inventory
		#something like : body.inventory_add()
		#animate add item
		queue_free()
