extends Node

var template: Dictionary = {
	"usr" = {
		"contents" = {
			
		},
		"permissions" = "drwxr-xr-x",
		"owner" = "root",
		"group" = "root",
	},
	"bin" = {
		"contents" = {
			"ls" = {
			"contents" = "print('Goodbye World')",
			"permissions" = "brwxr-xr-x",
			"owner" = "root",
			"group" = "root",
			}
		},
		"permissions" = "drwxr-xr-x",
		"owner" = "root",
		"group" = "root",
	},
}
var currentFS:Dictionary={}

func path_to_nested(path: String):
	# Remove leading slashes and split by "/"
	var parts = path.trim_prefix("/").trim_suffix("/").split("/")
	var nested_access = fs.currentFS
	for part in parts:
		#print(len(parts))
		#print(parts.find(part))
		if parts.find(part) == len(parts)-1:
			nested_access = nested_access[part]
		else:
			nested_access = nested_access[part]["contents"]
	return nested_access

@warning_ignore("unused_parameter")
func newComputer(hostname: String,username: String,password: String):
	pass

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	currentFS = template.duplicate()
