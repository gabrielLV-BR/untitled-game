extends Panel

@onready var text : RichTextLabel = $MarginContainer/RichTextLabel
@onready var timer : Timer = $Timer

const CHAR_TIMING : float = 0.2
const BETWEEN_LINE_TIME : float = 3.0

func _ready():
	DialogueSystem.show_dialogue.connect(show_dialogue)
	
	timer.autostart = false
	timer.one_shot = true

func show_dialogue(dialogue: Dialogue):
	visible = true
	
	for line in dialogue.lines:
		await show_line(line)
		await wait(BETWEEN_LINE_TIME)
	
	visible = false

func show_line(line: String):
	text.text = ""
	for c in line:
		text.text = text.text + c
		if c != " ":
			await wait(CHAR_TIMING)

func wait(seconds: float):
	timer.start(seconds)
	return timer.timeout
