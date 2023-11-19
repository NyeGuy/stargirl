extends Area2D

const Laser = preload("res://Laser.tscn")
const ExplosionEffect = preload("res://ExplosionEffect.tscn")

signal player_death

export(int) var SPEED = 100

#movement of ship up and down in Y
func _process(delta):
	if Input.is_action_pressed("ui_up"):
		position.y -= SPEED * delta
	if Input.is_action_pressed("ui_down"):
		position.y += SPEED * delta
	if Input.is_action_just_pressed("ui_accept"):
		fire_laser()

#function to fire bullet
func fire_laser():
	#call an instance and put it in variable
	var laser = Laser.instance()
	var main = get_tree().current_scene
	#call it as an instance child of the main scene node
	main.add_child(laser)
	#set it's position to the position of the ship
	laser.global_position = global_position

#ship interacts with an object in the scene it gets cleared
func _on_Ship_area_entered(area):
	area.queue_free()
	queue_free()
	
func _exit_tree():
	#call current scene and create an instance variable
	var main = get_tree().current_scene
	var explosionEffect = ExplosionEffect.instance()
	#create a child for that instance
	main.add_child(explosionEffect)
	#set it's position to the position of the Enemy Area 2d node
	explosionEffect.global_position = global_position
	emit_signal("player_death")
	
	
	
