# Dynamic Dialogue Box

The Dynamic Dialogue Box is designed to type out text typewriter style.

## Usage

Typing out and completing the text is simple:
```gdscript
# Load with text and start typing animation
$DynamicDialogueBox.text = "The quick brown fox jumps over the lazy dog."
$DynamicDialogueBox.start()

# Immediately finish the text
$DynamicDialogueBox.complete()
```

For each syllable read the `syllable_read` signal is emitted. When the text completes the `completed` signal is emitted.

## Features

* Variable delay based on letters, spaces and punctuation
* Types out text typewriter style

## Contributions

I have some ideas to add animated and clickable word options and you have any ideas for how those can be implemented and run efficiently feel free to make a pull request. Eventually I will get to these features and share an updated version.

## License

Copyright 2022 "SenshellShark"
GNU General Public License 3.0
