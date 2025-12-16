extends Area2D

func _ready():
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)

func _on_body_entered(body):
	print("ENTER INTERACTION!")
	if body.is_in_group("player"):
		print("Player entered!")
		body.enter_interaction_area();

func _on_body_exited(body):
	print("EXIT INTERACTION!")
	if body.is_in_group("player"):
		print("Player entered!")
		body.exit_interaction_area();
