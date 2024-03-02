extends RigidBody3D


@export var speed = 5.0

var is_launched = false
var player_ref : Node # プレイヤーノードへの参照を設定する
var launch_velocity = Vector3(0, 0, -10) # 発射時の初期速度
var constant_speed = 10.0 # 等速直線運動を維持するための速度


func _ready():
	player_ref = $"../Player"


func _physics_process(_delta):
	if !is_launched:
		# プレイヤーのX位置と同期
		var player_position = player_ref.global_transform.origin
		global_transform.origin.x = player_position.x
		# スペースキーで発射
		if Input.is_action_just_pressed("ui_accept"):
			launch_ball()
	else:
		# 発射後、等速直線運動を維持
		linear_velocity = linear_velocity.normalized() * constant_speed


func launch_ball():
	is_launched = true
	linear_velocity = launch_velocity.normalized() * constant_speed
