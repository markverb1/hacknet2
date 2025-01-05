extends Control

var root: TreeItem
var currentItem

func populate_tree(tree:Tree,dict:Dictionary,parent:TreeItem=null):
	if parent == null:
		root = tree.create_item()
		root.set_text(0,"/")
		root.set_metadata(0,"/")
	for file in dict.keys():
		#print(file)
		#print(dict[file])
		var item: TreeItem
		if parent == null:
			item = tree.create_item(root)
		else:
			item = tree.create_item(parent)
		item.set_text(0,file)
		item.set_metadata(0,file)
		if dict[file]["permissions"][0] == "d":
			item.set_text(0,"/"+item.get_text(0))
			populate_tree(tree,dict[file]["contents"],item)
	
func _checkbox_pressed():
	if currentItem == null:
		return
	if $"Window/Perms/1".button_pressed:
		currentItem["permissions"][1] = "r"
	else:
		currentItem["permissions"][1] = "-"
	if $"Window/Perms/2".button_pressed:
		currentItem["permissions"][2] = "w"
	else:
		currentItem["permissions"][2] = "-"
	if $"Window/Perms/3".button_pressed:
		currentItem["permissions"][3] = "x"
	else:
		currentItem["permissions"][3] = "-"
	if $"Window/Perms/4".button_pressed:
		currentItem["permissions"][4] = "r"
	else:
		currentItem["permissions"][4] = "-"
	if $"Window/Perms/5".button_pressed:
		currentItem["permissions"][5] = "w"
	else:
		currentItem["permissions"][5] = "-"
	if $"Window/Perms/6".button_pressed:
		currentItem["permissions"][6] = "x"
	else:
		currentItem["permissions"][6] = "-"
	if $"Window/Perms/7".button_pressed:
		currentItem["permissions"][7] = "r"
	else:
		currentItem["permissions"][7] = "-"
	if $"Window/Perms/8".button_pressed:
		currentItem["permissions"][8] = "w"
	else:
		currentItem["permissions"][8] = "-"
	if $"Window/Perms/9".button_pressed:
		currentItem["permissions"][9] = "x"
	else:
		currentItem["permissions"][9] = "-"
	update_perms()
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#print(fs.template)
	populate_tree($Window/Tree,fs.template)
	for box in $Window/Perms.get_children():
		if box is CheckBox:
			box.pressed.connect(_checkbox_pressed)

func update_perms() -> void:
	$Window/Perms/RichTextLabel.text = "[font_size=24]"+currentItem["permissions"].substr(1, 9)+"[/font_size]"
	$Window/Perms/type.text = currentItem["permissions"][0]
	$Window/Perms/"1".button_pressed = currentItem["permissions"][1] == "r"
	$Window/Perms/"2".button_pressed = currentItem["permissions"][2] == "w"
	$Window/Perms/"3".button_pressed = currentItem["permissions"][3] == "x"
	$Window/Perms/"4".button_pressed = currentItem["permissions"][4] == "r"
	$Window/Perms/"5".button_pressed = currentItem["permissions"][5] == "w"
	$Window/Perms/"6".button_pressed = currentItem["permissions"][6] == "x"
	$Window/Perms/"7".button_pressed = currentItem["permissions"][7] == "r"
	$Window/Perms/"8".button_pressed = currentItem["permissions"][8] == "w"
	$Window/Perms/"9".button_pressed = currentItem["permissions"][9] == "x"
	$Window/Perms/owner.text = currentItem["owner"]
	$Window/Perms/group.text = currentItem["group"]

func _on_tree_item_selected() -> void:
	
	currentItem = $Window/Tree.get_selected()
	var path = currentItem.get_metadata(0)
	if path == "/":
		return
	while currentItem != root:
		currentItem = currentItem.get_parent()
		path = currentItem.get_metadata(0) + "/" + path
	path = path.substr(1, path.length() - 1)
	currentItem = fs.path_to_nested(path)
	update_perms()
	
func _on_group_text_changed(new_text: String) -> void:
	if currentItem == null:
		return
	if new_text == "":
		new_text = "root"
	currentItem["group"] = new_text

func _on_owner_text_changed(new_text: String) -> void:
	if currentItem == null:
		return
	if new_text == "":
		new_text = "root"
	currentItem["owner"] = new_text

func _on_type_text_changed(new_text: String) -> void:
	if currentItem == null:
		return
	if new_text == "":
		new_text = "-"
	currentItem["permissions"][0] = new_text
