extends Node

var lua: LuaAPI
var coroutines: Array

func do_string(program:String):
	lua = LuaAPI.new()
	# Despite the name, this is not like a OS coroutine. It is a coroutine.
	coroutines.append(lua.new_coroutine())
	var idx:int=coroutines.size()-1
	coroutines[idx].load_string(program)

func _ready():
	do_string("""
	while true do
		yield(1)
		print('Hello world!')
	end
	""")

var yieldTime = 0
var timeSince = 0
func _process(delta):
	for coroutine in coroutines:
		timeSince += delta
		# If the coroutine has finished executing or if not enough time has passed, do not resume the coroutine.
		if coroutine.is_done() || timeSince <= yieldTime:
			return
		# coroutine.resume will either return a LuaError or an Array.
		var ret = coroutine.resume([])
		if ret is LuaError:
			print("ERROR %d: " % ret.type + ret.msg)
			return
		# Assumes the user will always pass the number of seconds to pause the coroutine for.
		yieldTime = ret[0]
		timeSince = 0
