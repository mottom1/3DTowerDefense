extends Area

func _on_Area_body_entered(body):
	GlobalVars.ShopVars.Money += 1
	queue_free()
