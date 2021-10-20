extends Area

func _on_Area_body_entered(body):
	body.Coins += 1
	queue_free()
