extends CharacterBody2D
@onready var player_life = %PlayerLife

#####################Animation variables#####################
@onready var animacao = %PlayerAnimation
@onready var attack_area = $PlayerAttackArea
var isAttacking = false
var isLeft = false
#####################Animation variables#####################

#####################Movement variables#####################
const SPEED = 100.0
var last_velocityLR = 0
var last_velocityUD = 0
var last_key = 0 #Identify if moving left/right(1) or up/down(0)
#####################Movement variables#####################

func moving():
	#left and right movement
	var directionLR = Input.get_axis("Left", "Right")
	if directionLR:
		last_key = 1
		last_velocityLR = directionLR
		velocity.x = directionLR * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, 8)
		
	#Up and down movement
	var directionUD = Input.get_axis("Up", "Down")
	if directionUD:
		last_key = 0
		last_velocityUD = directionUD
		velocity.y = directionUD * SPEED
	else:
		velocity.y = move_toward(velocity.y, 0, 8)
		
	move_and_slide()
	
func attacking():
	#Attacking verification
	if Input.is_action_just_pressed("Action") and last_key == 0:
		isAttacking = true
		$PlayerAttackArea/AttackShape.disabled = false
		if last_velocityUD > 0:
			animacao.play('attack down')
		elif last_velocityUD < 0:
			animacao.play('attack up') 
		
	if Input.is_action_just_pressed("Action") and last_key == 1:
		isAttacking = true
		$PlayerAttackArea/AttackShape.disabled = false
		animacao.play('attack side')
	
func animating():
	#Movement animation
	isLeft = last_velocityLR < 0
	animacao.flip_h = isLeft
	
	if velocity.x < 0 and isAttacking == false:
		if velocity.y == 0: #left
			animacao.play('walk side') 
			get_node("PlayerAttackArea").set_rotation_degrees(90)
		elif velocity.y < 0: #left up
			animacao.play('walk side up')
			get_node("PlayerAttackArea").set_rotation_degrees(135)
			
		elif velocity.y > 0: #left down
			animacao.play('walk side down')
			get_node("PlayerAttackArea").set_rotation_degrees(45)
	

	elif velocity.x > 0 and isAttacking == false:
		if velocity.y == 0: #right
			animacao.play('walk side') 
			get_node("PlayerAttackArea").set_rotation_degrees(270)
			
		elif velocity.y < 0: #right up
			animacao.play('walk side up')
			get_node("PlayerAttackArea").set_rotation_degrees(225)
			
		elif velocity.y > 0: #right down
			animacao.play('walk side down')
			get_node("PlayerAttackArea").set_rotation_degrees(315)

	elif velocity.x == 0:
		if velocity.y < 0 and isAttacking == false:
			animacao.play('walk up') #up
			get_node("PlayerAttackArea").set_rotation_degrees(180)
			
		elif velocity.y > 0 and isAttacking == false:
			animacao.play('walk down') #down
			get_node("PlayerAttackArea").set_rotation_degrees(0)
			
		elif velocity.y == 0:
			if last_velocityUD > 0 and last_key == 0 and isAttacking == false:
				animacao.play('idle') #down
			elif last_velocityUD < 0 and last_key == 0 and isAttacking == false:
				animacao.play('idle up') #up
			if last_velocityLR > 0 and not last_key == 0 and isAttacking == false:
				animacao.play('idle side') #right
			elif last_velocityLR < 0 and not last_key == 0 and isAttacking == false:
				animacao.play('idle side') #left
	else:
		pass
	
func _process(delta):
	moving()
	animating()
	attacking()
	
func _on_player_animation_animation_finished():
	if animacao.animation == 'attack side'or animacao.animation == 'attack up' or animacao.animation == 'attack down':
		$PlayerAttackArea/AttackShape.disabled = true
		isAttacking = false


