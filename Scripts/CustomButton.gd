extends Button

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

var callbackFunc
var arg

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func SetTextButton(_text):
	set_text(_text)

func SetFunctionButton(_function,_arg):
	callbackFunc = _function
	arg = _arg

func _on_Button_pressed():
	callbackFunc.call_func(arg)

func Delete():
	self.queue_free()