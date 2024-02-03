extends Control


signal score_over


func _ready():
	var scores = get_node("/root/Scores")
	for i in range(len(scores.all_scores) - 1, -1, -1):
		var t = ""
		if scores.all_scores[i][0]:
			t = "%s:\tWon game in \t%.2f\n" % [scores.all_scores[i][2], scores.all_scores[i][1]]
		else:
			t = "%s:\tLost game in \t%.2f\n" % [scores.all_scores[i][2], scores.all_scores[i][1]]
		$RichTextLabel.add_text(t)


func _process(delta):
	if Input.is_action_pressed("ui_back"):
		score_over.emit()


func _on_button_pressed():
	score_over.emit() # Replace with function body.
