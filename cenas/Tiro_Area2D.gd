extends Area2D

const MAX_DIST = 1050

var vel = 700

var dir = Vector2(0, -1) setget set_dir
onready var int_pos = global_position

var live = true

func _ready():
	pass 

func _process(delta):
	
	if live:
		if global_position.distance_to(int_pos) >= MAX_DIST:
			altodestroy()
			
		translate(dir * vel * delta)
		

# Mostra se o objeto saiu da tela 
func _on_VisibilityNotifier2D_screen_exited():
	queue_free() #Apaga o obijeto da memoria quanto esta seguro  
	
	pass # Replace with function body.

func set_dir(val):
	dir = val 
	rotation = dir.angle() 
	pass

func _on_Tiro_Area2D_body_entered(body):
	if body.collision_layer == 1 or body.collision_layer == 3:
		altodestroy()
		pass
		
func altodestroy():
		$"fumaça".emitting = false
		live = false
		$"bulletRed1_outline".visible = false 
		$anime_self_destruction.play("explode")
		# Desabilita coliçoes 
		call_deferred("set_monittoring", false)
		call_deferred("monitrorable", false)
		# yield espara o comando terminar antes de passar para a frente 
		yield($anime_self_destruction, "animation_finished") 
		queue_free()
