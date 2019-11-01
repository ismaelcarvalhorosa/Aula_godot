extends KinematicBody2D

var andar = 4
var speed = 50
var acell = 0
var posicao_mouse = get_global_mouse_position()

func _ready():
	pass

func _physics_process(delta):
		
	var vel_mod = 1
	var dir_x = 0
	var dir_y = 0

	if Input.is_action_pressed("ui_right_mira"):
		dir_x += andar

	if Input.is_action_pressed("ui_left_mira"):
		dir_x -= andar

	if Input.is_action_pressed("ui_up_mira"):
		dir_y -= andar

	if Input.is_action_pressed("ui_down_mira"):
		dir_y += andar
	
	#Verivica se o mouse ou o controle esta sendo usado 
	if dir_x != 0 or dir_y != 0:
		move_and_slide( Vector2(dir_x, dir_y) * speed )
	elif posicao_mouse != get_global_mouse_position():
		set_global_position(get_global_mouse_position()) # posisiona o objeto na posição do mase

	posicao_mouse = get_global_mouse_position()
	
	