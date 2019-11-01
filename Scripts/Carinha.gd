tool
extends KinematicBody2D

onready var tiro_grupo = "tiro-" + str(self) # configura os gupos 

const ROT_VEL = PI
const dead_zone = 0.02

const MAX_SPEED = 100 
var andar = 4
var speed = 50
var pre_tiro = preload("res://cenas/Tiro_Area2D.tscn") # preload carrega a variavel quanto o jogo é iniciado
var pre_pegada = preload("res://cenas/pegada.tscn") 
var mira = preload("res://cenas/mira.tscn")
var posicao_mouse = get_global_mouse_position()

var travel = 0
var acell = 0

export(int , "Revolver", "Espigarda cano curto cima", "revolver ouro") var arma = 1 setget set_arma

var armas = [
	"res://img/armas/Revolver.png",
	"res://img/armas/Espigarda cano curto cima.png",
	"res://img/armas/revolver ouro.png"
]

func _ready():
	pass
	
func _draw():
	$revolver/Revolver.texture = load(armas[arma])

func _physics_process(delta):
	
	if Engine.editor_hint:
		return
		
	var vel_mod = 1
	
	if get_tree().get_nodes_in_group(str(self) + "agua").size() > 0:
		vel_mod = 0.5
	
	var dir_x = 0
	var dir_y = 0

	if Input.is_action_pressed("ui_right"):
		dir_x += andar

	if Input.is_action_pressed("ui_left"):
		dir_x -= andar

	if Input.is_action_pressed("ui_up"):
		dir_y -= andar

	if Input.is_action_pressed("ui_down"):
		dir_y += andar
#
	if Input.is_action_just_pressed("ui_shoot"):

		if get_tree().get_nodes_in_group(tiro_grupo).size() < 5:
			var tiro = pre_tiro.instance()
			tiro.global_position = $revolver/disparo.global_position
			tiro.dir = Vector2(cos(rotation), sin(rotation)).normalized()
			tiro.add_to_group(tiro_grupo)
			$"../".add_child(tiro)
			$revolver/AnimationPlayer.play("fire")

	var r_hor_axis = Input.get_joy_axis(0, JOY_AXIS_2)
	var r_ver_axis = Input.get_joy_axis(0, JOY_AXIS_3)
	
	# zera a variavel caso o joy extique esteja mandando um valor sem o jogador precionar nada 
	#abs = mostra o valor abisoluto sem(sem sinal de - ou de +)
	if abs(r_hor_axis) < dead_zone: 
		r_hor_axis = 0 
	if abs(r_ver_axis) < dead_zone: 
		r_ver_axis = 0 
	
	var posi_mira = $mira.get_global_position()

	#$"Chapel de cima".global_position = Vector2(90, 60).normalized().angle()
	#pega a posição do mouse e mira nele
#	look_at($mira.get_global_position())
	if r_hor_axis != 0 or posicao_mouse != get_global_mouse_position():
		look_at(posi_mira)
		print(str($mira.get_global_position()))
		
	posicao_mouse = get_global_mouse_position()
	#look_at(get_global_mouse_position())
	move_and_slide( Vector2(dir_x, dir_y) * speed * vel_mod)
	
	
	
	var rot = 0
	var dir = 0
#
#	if Input.is_action_pressed("ui_right"):
#		rot += 1
#
#	if Input.is_action_pressed("ui_left"):
#		rot -= 1
#
#	if Input.is_action_pressed("ui_up"):
#		dir += andar
##
#	if Input.is_action_pressed("ui_down"):
#		dir -= andar
#
#	rotate(ROT_VEL * rot * delta)
#
#	acell = lerp(acell, MAX_SPEED * dir, .01)
#
	#var move = move_and_slide(Vector2(cos(rotation), sin(rotation)) * vel_mod)  # Direção do vetor 

	#travel += move.length()
	
	if travel >= 15:
		travel = 0
		var pegada = pre_pegada.instance() 
		pegada.global_position = global_position - Vector2(cos(rotation), sin(rotation)).normalized() * 5
		pegada.rotation = rotation 
		pegada.z_index = z_index - 1 
		$"../".add_child(pegada)		
		
	#$".".global_rotation = Vector2(r_ver_axis, r_ver_axis).normalized().angle()
	
	#$"Chapel de cima".global_rotation = Vector2(r_hor_axis, r_ver_axis).normalized().angle()
#	$revolver.look_at(get_global_mouse_position())
	
func set_arma(val):
		arma = val
		if Engine.editor_hint:
			update()
		