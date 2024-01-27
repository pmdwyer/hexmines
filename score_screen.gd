extends Control


signal score_over


func _ready():
	var scores = get_node("/root/Scores")
	for s in scores.all_scores:
		var t = ""
		if s[0]:
			t = "Won game in \t%.2f\n" % s[1]
		else:
			t = "Lost game in \t%.2f\n" % s[1]
		$RichTextLabel.add_text(t)


func _process(delta):
	if Input.is_action_pressed("ui_back"):
		score_over.emit()


func _on_button_pressed():
	score_over.emit() # Replace with function body.
