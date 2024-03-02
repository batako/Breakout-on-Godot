extends Node3D


@onready var ball: RigidBody3D = $Ball
@onready var label: Label = $Control/MarginContainer/TryLabel

var retry: int


func _ready() -> void:
	retry = 0


func _on_ball_retry() -> void:
	retry += 1
	label.text = "RETRY: " + str(retry)
