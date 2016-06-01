
extends Area2D

const SPEED = 200
var exploted = false
var prev_shoot = false
var killed = 0

func _ready():
	set_process(true)

func _process(delta):
	if exploted:
		return
	var dir=Vector2()
	
	if (Input.is_action_pressed("player_down")):
		dir+=Vector2(0,1)
	if (Input.is_action_pressed("player_up")):
		dir+=Vector2(0,-1)
	if (Input.is_action_pressed("player_left")):
		dir+=Vector2(-1,0)
	if (Input.is_action_pressed("player_right")):
		dir+=Vector2(1,0)
	
	var pos = get_pos()
	pos+=dir * delta * SPEED
	var size = get_viewport_rect().size
	
	pos.x = clamp(pos.x, 0, size.x)
	pos.y = clamp(pos.y, 0, size.y)
	set_pos(pos)
	
	var shoot = Input.is_action_pressed("player_shot")
	if (shoot and not prev_shoot):
		var shot_res = preload("res://player/shot.xml")
		var shot_scn = shot_res.instance()
		pos.y = pos.y - 32
		shot_scn.set_pos( pos )
		get_parent().add_child( shot_scn )
	prev_shoot = shoot

func exploit():
	if (exploted):
		return
	get_node("sprite").hide()
	get_node("explosion").set_emitting(true)
	get_node("sample").play("explosion")
	exploted=true
	
func enemy_killed():
	killed += 1
	#get_tree().get_root().get_node("level1/info").
