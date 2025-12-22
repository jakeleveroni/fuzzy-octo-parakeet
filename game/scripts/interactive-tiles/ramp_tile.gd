extends Area2D

var bias: int = -600;

func _ready():
	body_entered.connect(_on_body_entered)

func _on_body_entered(body):
	print("ENTER RAMP!")
	if body.is_in_group("player"):
		body.set_y_bias(bias)

func _on_body_exited(body):
	print("EXIT RAMP!")
	if body.is_in_group("player"):
		body.set_y_bias(0)
