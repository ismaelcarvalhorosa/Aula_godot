extends Area2D


func _ready():
	pass 

func _on_agua_body_entered(body):
	add_to_group(str(body) + "agua")

func _on_agua_body_exited(body):
	remove_from_group(str(body) + "agua")
	