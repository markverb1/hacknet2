extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_danger_toggled(toggled_on: bool) -> void:
	$Window/RM.disabled = !toggled_on

func _on_new_machine_pressed() -> void:
	pass # Replace with function body.
