extends CharacterBody2D

const WIND_FORCE := 2.2 #added juice to the player's input
const MAX_WIND_PUSH := 1600 #caps the amount of force the player can give
const AIR_RES := 0.02 #between 0 and 1, larger means more

var mouse_pressed := false
var last_mouse_down := Vector2(0,0)
var last_mouse_up := Vector2(0,0)

var wind_vector := Vector2(0,0)

func _ready() -> void:
	$AnimationPlayer.play("Fall")
	$CollisionPolygon2D.polygon = $Polygon2D.polygon


func _physics_process(delta: float) -> void:
	#Apply air resistance
	velocity *= (1-AIR_RES)
	
	#Apply gravity
	velocity.y += get_gravity().y
	
	move_and_slide()


func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			mouse_pressed = true
			last_mouse_down = event.position
		elif event.button_index == MOUSE_BUTTON_LEFT and not event.pressed:
			mouse_pressed = false
			last_mouse_up = event.position
			wind_vector = Vector2(last_mouse_up.x - last_mouse_down.x, last_mouse_up.y - last_mouse_down.y) * WIND_FORCE
			blow_leaf(wind_vector)


func blow_leaf(vec):
	var mag = vec.length()
	velocity += vec.normalized() * min(MAX_WIND_PUSH, mag)
