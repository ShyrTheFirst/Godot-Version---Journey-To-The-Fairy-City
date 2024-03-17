extends CharacterBody2D

@onready var timer = %Timer
@onready var enemy_animation = $EnemyAnimation

var movement = Vector2(0,0)
var last_movement = Vector2(0,0)
var health = 5
var damage = 1
var dx = 0
var dy = 0
var speed = 40.0
var knockbackForce = 10.0
var isKnocked = false
var delta_time = null
var moving = false
var searching = false
var player = null
var last_position

func move_func(player_position):	
	if not isKnocked:
		last_movement = movement
		var player_pos = player_position
		var enemy_pos = self.global_position
		dx = player_pos[0] - enemy_pos[0]
		dy = player_pos[1] - enemy_pos[1]
		var dist = pow((dx ** 2 + dy ** 2),0.5)
		if dist != 0:
			dx = dx / dist
			dy = dy / dist
		var velx = dx * speed * delta_time
		var vely = dy * speed * delta_time
		movement = Vector2(velx,vely)
			
		move_and_collide(movement)

func animating():
	var x = movement[0]
	var y = movement[1]
	
	
	if x > 0:
		if x > 0.1:
			if y > 0.1:
				enemy_animation.play("walk right down")
				get_node("Attackbox").set_rotation_degrees(315)
			elif y < -0.1:
				enemy_animation.play("walk right up")
				get_node("Attackbox").set_rotation_degrees(225)
			if y > 0 and y < 0.2:
				enemy_animation.play("walk right")
				get_node("Attackbox").set_rotation_degrees(270)
			
		elif x < 0.1:
			if y < 0.6:
				enemy_animation.play("walk up")
				get_node("Attackbox").set_rotation_degrees(180)
				
	elif x < 0:
		if x < -0.1:
			if y > 0.1:
				enemy_animation.play("walk left down")
				get_node("Attackbox").set_rotation_degrees(45)
			elif y < -0.1:
				enemy_animation.play("walk left up")
				get_node("Attackbox").set_rotation_degrees(135)
			if y < 0 and y > -0.1:
				enemy_animation.play("walk left")
				get_node("Attackbox").set_rotation_degrees(90)
			
		elif x > -0.1:
			if y > 0.5:
				enemy_animation.play("walk down")
				get_node("Attackbox").set_rotation_degrees(0)

func _process(delta):
	delta_time = delta
	
	if moving:
		var space_state = get_world_2d().direct_space_state
		var query = PhysicsRayQueryParameters2D.create(global_position, player.global_position, collision_mask)
		var result = space_state.intersect_ray(query)
		if result: 
			if result.collider.name == 'Player':
				last_position = result.position
				move_func(result.position)
				animating()
				
	if searching:
		move_func(last_position)
		if round(position) == round(last_position):
			last_position = position
			searching = false

func knockback(EnemyVelocity):
	var knockbackDirection = (EnemyVelocity - movement).normalized() * knockbackForce
	velocity = knockbackDirection
	move_and_collide(velocity)
	isKnocked = true
	timer.start()

func _on_attackbox_body_entered(body):
	if body.name == 'Player':
		#isKnocked = true
		knockback(player.velocity)
		PlayerVar.health -= damage
		PlayerVar.frac_health = int((100*PlayerVar.health)/PlayerVar.max_health)

func _on_timer_timeout():
	isKnocked = false

func _on_detection_area_body_entered(body):
	if body.name == "Player":
		player = body
		moving = true
		searching = false

func _on_detection_area_body_exited(body):
	if body.name == "Player":
		moving = false
		searching = true

func _on_enemy_hitbox_area_entered(area):
	if area.is_in_group('Attack'):
		#animated damage
		knockback(player.velocity)
		health -= PlayerVar.damage
		if health <= 0:
			#body.add_points()
			queue_free()
