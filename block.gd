extends Area3D


var entered_body = null


func _on_body_entered(body: Node3D) -> void:
	if body.name == "Ball":
		entered_body = body


func _on_body_exited(body: Node3D) -> void:
	if body == entered_body:
		queue_free()
