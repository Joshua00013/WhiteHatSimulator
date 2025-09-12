extends Control

@export var quiz_title : Label
@export var question_label : Label
@export var button_a : Button
@export var button_b : Button
@export var button_c : Button
@export var button_d : Button
@export var timer_label : Label
@export var timer : Timer
@export var score_label : Label

signal quiz_finished(point_counter : int)

var current_question : int = 0
var point_counter : int = 0

var questions = [
	{
		"question":"What is the main goal of a ransomware attack?",
		"answers":[
			"A. To secretly spy on internet activity",
			"B. To encrypt files and demand payment",
			"C. To delete all system files permanently",
			"D. To improve computer performance"
		],
		"correct_answer": 1
	},
	{
		"question":"Which of the following is the way ransomware most often enters a system?",
		"answers":[
			"A. Fake emails with attachments or links",
			"B. Downloading system updates",
			"C. Installing antivirus software",
			"D. Using strong passwords"
		],
		"correct_answer": 0
	},
	{
		"question":"As a student why do we need how ransomware attack works?",
		"answers":[
			"A. To help victims recover files faster",
			"B. To build stronger and harder-to-detect attacks",
			"C. To prevent other hackers from attacking",
			"D. To teach cybersecurity classes"
		],
		"correct_answer": 2
	},
	{
		"question":"Why should you avoid downloading software from untrusted sources?",
		"answers":[
			"A. It makes your computer slower",
			"B. It might contain hidden ransomware or malware",
			"C. It always costs more money",
			"D. It doesn’t allow backups"
		],
		"correct_answer": 1
	},
	{
		"question":"Which practice makes it harder for hackers to guess or steal your account access?",
		"answers":[
			"A. Using simple passwords like “12345”",
			"B. Writing your password on your desk",
			"C. Using strong, unique passwords with MFA",
			"D. Sharing passwords with friends"
		],
		"correct_answer": 2
	},
	{
		"question":"What role does antivirus and firewall software play in ransomware defense?",
		"answers":[
			"A. A. They store backup files",
			"B. They stop suspicious activity and known threats",
			"C. They make the internet faster",
			"D. They create new encryption keys"
		],
		"correct_answer": 1
	},
	{
		"question":"Which of the following is an example of being cautious online?",
		"answers":[
			"A. Clicking links from unknown emails",
			"B. Backing up files and avoiding shady downloads",
			"C. Ignoring software updates",
			"D. Disabling your antivirus program"
		],
		"correct_answer": 1
	},
	
]

func _ready() -> void:
	timer.timeout.connect(_on_timer_timeout)

	# Connect button presses with their index
	button_a.pressed.connect(_on_answer_pressed.bind(0))
	button_b.pressed.connect(_on_answer_pressed.bind(1))
	button_c.pressed.connect(_on_answer_pressed.bind(2))
	button_d.pressed.connect(_on_answer_pressed.bind(3))

	display_question(current_question)

func _physics_process(_delta: float) -> void:
	timer_label.text = str(timer.time_left)

func display_question(array_number: int) -> void:
	if array_number < questions.size():
		var quiz_item = questions[array_number]
		question_label.text = quiz_item["question"]

		var answers = quiz_item["answers"]
		button_a.text = answers[0]
		button_b.text = answers[1]
		button_c.text = answers[2]
		button_d.text = answers[3]

func _on_answer_pressed(answer_index: int) -> void:
	var quiz_item = questions[current_question]

	if answer_index == quiz_item["correct_answer"]:
		point_counter += 1
		score_label.text = "Score: " + str(point_counter)
		print("✅ Correct!")
	else:
		print("❌ Wrong! Correct answer: " + quiz_item["answers"][quiz_item["correct_answer"]])

	# Move to next question
	current_question += 1
	if current_question < questions.size():
		display_question(current_question)
	else:
		quiz_finished.emit(point_counter)
		print("🎉 Quiz finished! Final Score: ", point_counter)

func _on_timer_timeout() -> void:
	current_question += 1
	if current_question < questions.size():
		display_question(current_question)
	else:
		quiz_finished.emit(point_counter)
		print("⏰ Time’s up! Quiz finished! Final Score: ", point_counter)
