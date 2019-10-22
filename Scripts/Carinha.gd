tool
extends KinematicBody2D

var tiro_grupo = "tiro-" + str(self) # configura os gupos 

var speed = 50 
var andar = 4
var pre_tiro = preload("res://cenas/Tiro_Area2D.tscn")

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
		
	if Input.is_action_just_pressed("ui_shoot"):
		
		if get_tree().get_nodes_in_group(tiro_grupo).size() < 5:
			var tiro = pre_tiro.instance()
			tiro.global_position = $revolver/disparo.global_position
			tiro.dir = Vector2(cos(rotation), sin(rotation)).normalized()
			tiro.add_to_group(tiro_grupo)
			$"../".add_child(tiro)
			$revolver/AnimationPlayer.play("fire")
	
	look_at(get_global_mouse_position())
		
	move_and_slide( Vector2(dir_x, dir_y) * speed)
	

func set_arma(val):
		arma = val
		if Engine.editor_hint:
			update()
		