extends Container

var margin: Vector2
var font: Font

var line_count : int = 1

func _ready():
	font = get_font("font", "Label")
	margin = Vector2(font.get_string_size(" ").x, font.get_height())

#func _on_Container_sort_children():
#	var total_width = 0
#	var width = rect_size.x
#	var row_width = 0
#	var row_index = 0
#	for word in get_children():
#		var word_width = word.rect_size.x + margin.x
#		if row_width + word_width > width:
#			row_width = 0
#			row_index += 1
#		word.rect_position = Vector2(row_width, row_index * margin.y)
#		row_width += word_width

func _on_Container_sort_children():
	var text = get_parent().text
	var words = text.split(" ")
	var max_width = get_rect().size.x
	var row_width = 0
	var row_index = 0
	var labels = get_children()
	var label_index = 0
	for word in words:
		var word_width = font.get_string_size(word).x
		if row_width + word_width > max_width:
			row_width = 0
			row_index += 1
		var letters_width = 0
		for letter in word:
			var letter_width = font.get_string_size(letter).x
			labels[label_index].rect_position = Vector2(row_width + letters_width, row_index * (margin.y + get_parent().line_space))
			letters_width += letter_width
			label_index += 1
		row_width += word_width + margin.x + get_parent().word_space
