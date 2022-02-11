extends Control

##
## An set of scenes to make displaying dialogue easy
##
## @desc:
##		The Dynamic Dialogue Box is designed to type out text typewriter style.
##
## Usage:
##		[codeblock]
##		func _on_pressed():
##			$DynamicDialogueBox.text = "The quick brown fox jumps over the lazy dog."
##			$DynamicDialogueBox.start()
##		[/codeblock]
##

## Emitted when a syllable is read out. The frequency of this can be adjusted with syllable_size
signal syllable_read

## Emitted when the text has finished typing out
signal completed

## The working version of the text including all the tags given. See get_plain_text for the text without tags.
export var text: String = "" setget set_text

## True when the text is all visible
var is_complete: bool = false

## Additional space between words
export var word_space: float = 0

## Additional space between each line of text
export var line_space: float = 0

export var seconds_per_letter: float = 0.008
export var seconds_per_space: float = 0.02
export var seconds_per_punctuation: float = 0.5
export var seconds_per_other_characters: float = 0.05

## The size of the syllable by which the signal syllable_read is emitted when the text is being read out
export var syllable_size: int = 3

var computed_delays: PoolRealArray = []
var read_index: int = 0

var letters_regex: RegEx = RegEx.new()
var punctuation_regex: RegEx = RegEx.new()

func _ready():
	letters_regex.compile("[:alpha:]")
	punctuation_regex.compile("[.!?;]")
	
func set_text(t: String):
	text = t
	var letters = text
	var letter_index = 0
	computed_delays = []
	var space_delay: bool = false
	for letter in letters:
		if letter == " ":
			computed_delays[-2] += seconds_per_space
			continue
		var delay = seconds_per_other_characters
		if letters_regex.search(letter):
			delay = seconds_per_letter
		if punctuation_regex.search(letter):
			computed_delays[-1] += seconds_per_punctuation
		computed_delays.append(delay)
		var letter_label = Label.new()
		letter_label.text = letter
		letter_index += 1
		letter_label.modulate = Color(1, 1, 1, 0)
		$Container.add_child(letter_label)

func start():
	$ReadTimer.start()

func _on_ReadTimer_timeout():
	if read_index % syllable_size == 0:
		emit_signal("syllable_read")
	if read_index < computed_delays.size():
		var wait: float = computed_delays[read_index - 1]
		$Container.get_children()[read_index].modulate = Color(1, 1, 1, 1)
		$ReadTimer.wait_time = wait
		read_index += 1
		$ReadTimer.start()
	else:
		is_complete = true
		emit_signal("completed")

func complete():
	for label in $Container.get_children():
		label.modulate = Color(1, 1, 1, 1)
	is_complete = true
	emit_signal("completed")
