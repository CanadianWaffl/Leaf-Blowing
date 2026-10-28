extends Node2D

@onready var leaf = $Leaf

var mouse_pressed := false
var last_mouse_down := Vector2(0,0)
var last_mouse_up := Vector2(0,0)

func _ready() -> void:
	leaf.position = get_viewport_rect().size / 2


func _process(delta: float) -> void:
	if mouse_pressed:
		queue_redraw()


func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			mouse_pressed = true
			last_mouse_down = event.position
		elif event.button_index == MOUSE_BUTTON_LEFT and not event.pressed:
			mouse_pressed = false
			last_mouse_up = event.position
			queue_redraw()


func _draw() -> void:
	if mouse_pressed:
		draw_dashed_line(last_mouse_down, get_global_mouse_position(), Color(0.979, 0.972, 0.742, 1.0), 7.0, 8.0)
	pass
