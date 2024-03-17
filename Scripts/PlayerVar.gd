extends Node

#####################General variables#####################
var exp = 0
var max_health = 50
var health = 50
var level = 1
var lvl_up_calc = level*100
var damage = 1
var deffense = 0
var frac_health = 100
#####################General variables#####################

#####################Equipments variables#####################
var axe_nv = 0
var helmet_nv = 0
var armor_nv = 0

var deffense_helmet = 0
var deffense_armor = 0
var attack_axe = 0
#####################Equipments variables#####################

func equips_change(type,level): #Call this when level up equipments
	if type == 'axe':
		axe_nv += level
	if type == 'armor':
		armor_nv += level
	if type == 'helmet':
		helmet_nv += level
	Itens_level()
	
func Itens_level(): #Call this when updating equips level
	if helmet_nv < 5:
		deffense_helmet = 0
	elif helmet_nv > 5 and helmet_nv < 10:
		deffense_helmet = 1
	elif helmet_nv > 10 and helmet_nv < 20:
		deffense_helmet = 2
	#[...]	
	if armor_nv < 5:
		deffense_armor = 0
	elif armor_nv > 5 and armor_nv < 10:
		deffense_armor = 2
	elif armor_nv > 10 and armor_nv < 20:
		deffense_armor = 5
	#[...]	
	if axe_nv < 5:
		attack_axe = 1
	elif axe_nv > 5 and axe_nv < 10:
		attack_axe = 3
	elif axe_nv > 10 and axe_nv < 20:
		attack_axe = 5
	#[...]	
	update_status(attack_axe, deffense_helmet, deffense_armor)
	
func update_status(axe_dmg, helmet_def, armor_def): #Update damage and def
	damage = (level*2) + axe_dmg
	deffense = helmet_def + armor_def
	
func level_up(): #call this to level up character
	if exp/lvl_up_calc >= 1:
		level += 1
		exp = exp - lvl_up_calc
		max_health = (1.2**level)*level+50
		Itens_level() 
		#animate lvl up
		frac_health = int((50*health)/max_health)
		
func _process(delta):
	Itens_level()
