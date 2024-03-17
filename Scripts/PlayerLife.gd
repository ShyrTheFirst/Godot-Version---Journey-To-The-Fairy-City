extends ColorRect

##################### H U D Variables#####################
@onready var animated_life_hud = $"../AnimatedLifeHUD"
@onready var timer = $Timer
var tamanho = Vector2(100,10)
var new_size = 100
var get_damage = false
##################### H U D Variables#####################

func _ready():
	animated_life_hud.play('main')

func _process(delta):
	size = tamanho
	new_size = PlayerVar.frac_health
	if size[0] > new_size or new_size > size[0]:
		size_change(new_size)
		modulate = Color.DARK_RED
		animated_life_hud.play('damage')
		get_damage = true
		timer.start()

	if not get_damage:
		if PlayerVar.frac_health > 74:
			modulate = Color.ANTIQUE_WHITE
			animated_life_hud.play('main')
		elif PlayerVar.frac_health < 74 and PlayerVar.frac_health > 50:
			modulate = Color.GREEN_YELLOW
			animated_life_hud.play('main')
		elif PlayerVar.frac_health < 50 and PlayerVar.frac_health > 25:
			modulate = Color.YELLOW
			animated_life_hud.play('main')
		elif PlayerVar.frac_health < 25:
			modulate = Color.ORANGE_RED
			animated_life_hud.play('main')
			
		
	
		

func size_change(new_x):
	var old_size = size[0]
	tamanho = Vector2(new_x, 10)


func _on_timer_timeout():
	get_damage = false
