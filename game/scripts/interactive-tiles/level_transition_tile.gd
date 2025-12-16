extends Area2D

@export var to_level_name: String;

func _ready():
	body_entered.connect(_on_body_entered)

func _on_body_entered(body):
	if body.is_in_group("player"):
		call_deferred("change_scene");


func change_scene():
	get_tree().change_scene_to_file(to_level_name);
