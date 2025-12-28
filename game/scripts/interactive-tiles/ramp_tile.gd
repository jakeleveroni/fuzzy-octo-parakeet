extends Area2D

var bias: float = 1.5;
@export var direction: DIRECTION = DIRECTION.UP_RIGHT; # TODO this is shared between tiles

enum DIRECTION {
	UP_LEFT,
	UP_RIGHT,
};

func _ready():
	body_entered.connect(_on_body_entered)

func _on_body_entered(body):
	print("ENTER RAMP!")
	print(direction)
	if body.is_in_group("player"):
		body.set_y_bias(bias, direction)

# TODO this ain't bein called
func _on_body_exited(body):
	print("EXIT RAMP!")
	if body.is_in_group("player"):
		body.set_y_bias(0, direction) # TODO this isn't working, also need to figure out how we want to set no direction
