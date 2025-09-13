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
	"question":"As a student, why is it important to understand how ransomware attacks work?",
	"answers":[
		"A. To protect our personal files and data from being encrypted",
		"B. To learn how to create stronger ransomware",
		"C. To pay the ransom more effectively",
		"D. To speed up the computer system"
	],
	"correct_answer": 0
	},
	{
		"question":"Why should you avoid opening attachments from unknown senders?",
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
	
	{
		"question":"Why is it risky to pay the ransom demanded by attackers?",
		"answers":[
			"A. Attackers may not provide the decryption key",
			"B. It always costs more than antivirus software",
			"C. The key only works once",
			"D. Payment makes files larger"
		],
		"correct_answer": 0
	},
		{
		"question":"What is a common sign your system may already be infected with ransomware?",
		"answers":[
			"A. Pop-up messages demanding payment",
			"B. Faster computer performance",
			"C. Extra free disk space",
			"D. Antivirus updates automatically stop"
		],
		"correct_answer": 0
	},
	{
		"question":"Which type of backup is most effective against ransomware?",
		"answers":[
			"A. Cloud or offline backup",
			"B. Only saving files on the same PC",
			"C. USB drive always connected",
			"D. Printing out documents"
		],
		"correct_answer": 0
	},
	
	{
		"question":"What is the purpose of patching and updating software regularly?",
		"answers":[
			"A. To make the interface look modern",
			"B. To close security vulnerabilities exploited by ransomware",
			"C. To improve screen resolution",
			"D. To delete old files automatically"
		],
		"correct_answer": 1
	},
	
		{
		"question":"Why is using pirated software dangerous?",
		"answers":[
			"A. It is always slower",
			"B. It often hides ransomware or malware",
			"C. It uses more RAM",
			"D. It drains battery faster"
		],
		"correct_answer": 1
	},
	{
		"question":"What is the safest action if you receive a suspicious email with an attachment?",
		"answers":[
			"A. Download but don’t open it",
			"B. Open it in incognito mode",
			"C. Delete it immediately",
			"D. Forward it to friends"
		],
		"correct_answer": 2
	},
	{
		"question":"What role does antivirus software play in preventing ransomware?",
		"answers":[
			"A. It completely removes all hackers",
			"B. It detects and blocks malicious files before execution",
			"C. It increases internet speed",
			"D. It updates Windows automatically"
		],
		"correct_answer": 1
	},
	{
		"question":"Which practice helps protect organizations from ransomware attacks?",
		"answers":[
			"A. Employee training on phishing awareness",
			"B. Giving admin access to all users",
			"C. Ignoring suspicious activity",
			"D. Allowing all downloads freely"
		],
		"correct_answer": 0
	},
	{
		"question":"Which of the following is a strong defense against ransomware?",
		"answers":[
			"A. Regular data backups",
			"B. Disabling antivirus software",
			"C. Ignoring system updates",
			"D. Using pirated software"
		],
		"correct_answer": 0
	},
	{
		"question":"Michelle receives an email from unknown account, saying she has won a free phone. The email asks her to download an attached file to claim her prize. What should Maria do?",
		"answers":[
			"A. Download and open the attachment immediately",
			"B. Reply to the email asking for more details",
			"C. Ignore or delete the email without opening the attachment",
			"D. Forward the email to all her friends"
		],
		"correct_answer": 2 	
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

func start_quiz():
	timer.start()

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
		timer.start()
		print("✅ Correct!")
	else:
		timer.start()
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
