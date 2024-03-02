extends RigidBody3D


@export var speed = 5.0

var is_launched = false
var player : RigidBody3D
# 発射時の初期速度
var launch_velocity = Vector3(0, 0, -10)
# 等速直線運動を維持するための速度
var constant_speed = 10.0
var bottom_wall: Area3D

signal retry

func _ready():
	player = $"../Player"
	bottom_wall = $"../Stage/Bottom"


func _physics_process(_delta):
	if !is_launched:
		# プレイヤーのXZ位置と同期
		var player_position = player.global_transform.origin
		global_transform.origin.x = player_position.x
		global_transform.origin.z = player_position.z - 0.5
		# スペースキーで発射
		if Input.is_action_just_pressed("ui_accept"):
			launch_ball()
	else:
		# 発射後、等速直線運動を維持
		linear_velocity = linear_velocity.normalized() * constant_speed


func launch_ball():
	is_launched = true
	linear_velocity = launch_velocity.normalized() * constant_speed


func _on_bottom_body_entered(body: Node3D) -> void:
	if is_launched:
		is_launched = false
		linear_velocity = Vector3.ZERO
		emit_signal("retry")
