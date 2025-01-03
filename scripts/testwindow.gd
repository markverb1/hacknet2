extends Control


@onready var parent = self.get_parent()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print(self.get_parent())


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_check_box_2_toggled(toggled_on: bool) -> void:
	parent.can_close = toggled_on

func _on_check_box_toggled(toggled_on: bool) -> void:
	parent.can_minimize = toggled_on

func _on_check_box_3_toggled(toggled_on: bool) -> void:
	parent.can_resize = toggled_on

func _on_line_edit_text_changed(new_text: String) -> void:
	parent.titlebar_text = new_text

func _on_option_button_item_selected(index: int) -> void:
	parent.icon = $OptionButton.get_item_icon(index)
