extends RigidBody3D


# マウスの感度
var mouse_sensitivity := 0.001
# カメラの水平方向の角度
var twist_input := 0.0
# カメラの垂直方向の角度
var pitch_input := 0.0

@onready var twist_pivot: Node3D = $TwistPivot
@onready var pitch_pivot: Node3D = $TwistPivot/PitchPivot


func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)


func _process(delta: float) -> void:
	handle_player_movement(delta)
	update_camera_state()
	
	if Input.is_action_just_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
			twist_input = -event.relative.x * mouse_sensitivity
			pitch_input = -event.relative.y * mouse_sensitivity


# 移動
func handle_player_movement(delta: float) -> void:
	var input := Vector3.ZERO
	input.x = Input.get_axis("move_left", "move_right")
	#input.y = Input.get_axis("move_back", "move_forward")
	apply_central_force(twist_pivot.basis * input * 2000.0 * delta)


# カメラの設定
func update_camera_state() -> void:
	# 水平方向設定
	twist_pivot.rotate_y(twist_input)
	# 垂直方向設定
	pitch_pivot.rotate_x(pitch_input)
	# 垂直方向の角度制限
	#pitch_pivot.rotation.x = clamp(pitch_pivot.rotation.x, -0.5, 0.5)
	pitch_pivot.rotation.x = clamp(pitch_pivot.rotation.x,
		deg_to_rad(-30),
		deg_to_rad(30)
	)
	# 初期化
	twist_input = 0.0
	pitch_input = 0.0
