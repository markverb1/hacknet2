extends Panel

@export var min_size:Vector2 = Vector2(200,200)
@export var max_size:Vector2 = Vector2(600,600)
@export var can_close:bool = true
@export var can_minimize:bool = true
@export var titlebar_text:String = "Test Window"

const defaultCursor=preload("res://assets/Posy's Cursor Black/Posy Black default-0.png")
const resizeCursor=preload("res://assets/Posy's Cursor Black/Posy Black size NwSe-0.png")
const minimizeButtonTexture = preload("res://assets/gui/resize.png")
const unminimizeButtonTexture = preload("res://assets/gui/minimize.png")
var oldSize:Vector2 = self.size
var minimized:bool = false

func _ready() -> void:
	$Titlebar/Close.disabled = not can_close
	$Titlebar/Minimize.disabled = not can_minimize
	$Titlebar/Label.text = titlebar_text

func _on_resize_gui_input(event: InputEvent) -> void:
	#print(event)
	#print(event)
	#InputEventMouseMotion
	if event is InputEventMouseMotion and Input.is_action_pressed("lmb"):
		#print("hell")
		Input.set_custom_mouse_cursor(resizeCursor)
		self.size += event.relative
		self.size.x = clamp(self.size.x,min_size.x,max_size.x)
		self.size.y = clamp(self.size.y,min_size.y,max_size.y)
	
	if Input.is_action_just_released("lmb"):
		Input.set_custom_mouse_cursor(defaultCursor)

func _on_resize_mouse_entered() -> void:
	Input.set_custom_mouse_cursor(resizeCursor)

func _on_resize_mouse_exited() -> void:
	Input.set_custom_mouse_cursor(defaultCursor)

func _on_titlebar_gui_input(event: InputEvent) -> void:
	#print(event)
	#print(event)
	#InputEventMouseMotion
	if event is InputEventMouseMotion and Input.is_action_pressed("lmb"):
		#self.position += event.relative
		self.position += event.relative
		#self.position.x = clamp(self.position.x,0,get_viewport().size.x-self.size.x)
		#self.position.y = clamp(self.position.y,0,get_viewport().size.y-self.size.y)


func _on_close_pressed() -> void:
	self.queue_free()


func _on_minimize_pressed() -> void:
	minimized = not minimized
	$Resize.visible = not minimized
	if minimized:
		$Titlebar/Minimize.icon = minimizeButtonTexture
		oldSize = self.size
		self.size.y = 32
	else:
		$Titlebar/Minimize.icon = unminimizeButtonTexture
		self.size = oldSize

func _process(_delta:float) -> void:
	self.position.x = clamp(self.position.x,0,get_viewport().size.x-self.size.x)
	self.position.y = clamp(self.position.y,0,get_viewport().size.y-self.size.y)
