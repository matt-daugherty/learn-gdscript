class_name UIQuizChoice
extends UIBaseQuiz

onready var _choices := $MarginContainer/ChoiceView/Answers as VBoxContainer


func setup(quiz: Quiz) -> void:
	yield(.setup(quiz), "completed")

	var answer_options: Array = _quiz.answer_options.duplicate()
	if _quiz.do_shuffle_answers:
		answer_options.shuffle()

	var button_font := get_font("default_font")
	if _quiz.is_multiple_choice:
		for answer in answer_options:
			var button := CheckBox.new()
			button.text = answer
			button.add_font_override("font", button_font)
			_choices.add_child(button)
	else:
		var group := ButtonGroup.new()
		for answer in answer_options:
			var button := Button.new()
			button.toggle_mode = true
			button.text = answer
			button.group = group
			button.add_font_override("font", button_font)
			_choices.add_child(button)


# Returns an array of indices of selected answers
func _get_answers() -> Array:
	var answer_buttons := _choices.get_children()
	var first_button = answer_buttons[0]
	var answers := []
	if first_button is CheckBox:
		for button in answer_buttons:
			if button.pressed:
				answers.append(button.text)
	else:
		answers = [first_button.group.get_pressed_button().text]
	return answers