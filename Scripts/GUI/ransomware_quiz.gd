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
@export var question_counter_label : Label

signal quiz_finished(point_counter : int)

var current_question : int = 0
var point_counter : int = 0
var question_counter: int =0

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
	{
		"question":"Michelle receives an email from an unknown account, saying she has won a free phone. The email asks her to download an attached file to claim her prize. What should Michelle do?",
		"answers":[
			"A. Download and open the attachment immediately",
			"B. Reply to the email asking for more details",
			"C. Ignore or delete the email without opening the attachment",
			"D. Forward the email to all her friends"
		],
		"correct_answer": 2
	},
	{
		"question":"John is browsing the internet and sees a pop-up saying 'Your computer is infected! Click here to fix.' What is the safest action?",
		"answers":[
			"A. Click the pop-up to install the recommended software",
			"B. Restart the computer immediately",
			"C. Close the pop-up and run a trusted antivirus scan",
			"D. Ignore it and continue browsing"
		],
		"correct_answer": 2
	},
	{
		"question":"Lisa plugs in a free USB drive she found in the school library. Suddenly, her files become unreadable. What likely happened?",
		"answers":[
			"A. Her computer is overheating",
			"B. She was infected with ransomware through the USB",
			"C. The USB drive is broken",
			"D. She accidentally formatted her computer"
		],
		"correct_answer": 1
	},
	{
		"question":"A ransomware message appears on Peter’s screen demanding money in cryptocurrency. What should he do?",
		"answers":[
			"A. Pay the ransom immediately to recover files",
			"B. Disconnect the computer from the internet and report it",
			"C. Restart the computer until the message disappears",
			"D. Share his private keys with the attacker"
		],
		"correct_answer": 1
	},
	{
		"question":"Anna is about to install a free software she downloaded from an unofficial website. What is the safest step she should take first?",
		"answers":[
			"A. Install the program right away",
			"B. Scan the file with an antivirus before opening",
			"C. Disable antivirus to speed up installation",
			"D. Share the program with friends before checking it"
		],
		"correct_answer": 1
	},
	{
		"question":"Mark gets an email from his teacher’s email address, but the message asks him to click a strange link to access homework. What should he suspect?",
		"answers":[
			"A. His teacher sent a normal assignment",
			"B. His teacher’s account may be hacked and spreading ransomware links",
			"C. It’s a system error",
			"D. It’s just spam and safe to ignore"
		],
		"correct_answer": 1
	},
	{
		"question":"A ransomware note says 'Your files are encrypted. Pay $200 or lose everything.' What is the best first step?",
		"answers":[
			"A. Immediately pay the ransom",
			"B. Try random passwords to unlock files",
			"C. Inform IT support or a cybersecurity expert",
			"D. Delete the encrypted files"
		],
		"correct_answer": 2
	},
	{
		"question":"Maria receives a file named 'grades_update.pdf.exe' from an unknown sender. What should she do?",
		"answers":[
			"A. Open it to see her grades",
			"B. Rename it and then open it",
			"C. Delete the file without opening it",
			"D. Forward it to classmates"
		],
		"correct_answer": 2
	},
	{
		"question":"David’s laptop shows a countdown timer demanding money to unlock files. What is this a sign of?",
		"answers":[
			"A. A harmless computer prank",
			"B. Normal system update",
			"C. A ransomware infection",
			"D. An internet connection error"
		],
		"correct_answer": 2
	},
	{
		"question":"Chloe keeps important documents only on her laptop without backups. If ransomware hits, what risk does she face?",
		"answers":[
			"A. Losing all her files permanently",
			"B. Slower internet browsing",
			"C. Using more disk space",
			"D. Receiving spam emails only"
		],
		"correct_answer": 0
	},
	{
		"question":"Tom receives an email that looks like it’s from his bank but has spelling errors and asks him to download an attachment. What should he do?",
		"answers":[
			"A. Download the attachment to check",
			"B. Call the bank directly to confirm the email",
			"C. Forward the email to friends",
			"D. Reply to the sender asking for more proof"
		],
		"correct_answer": 1
	},
	{
		"question":"Rachel’s computer files suddenly have strange extensions like '.locked'. What does this most likely mean?",
		"answers":[
			"A. The files were updated by Windows",
			"B. A ransomware program has encrypted her files",
			"C. She renamed them by mistake",
			"D. The storage drive is failing"
		],
		"correct_answer": 1
	},
	{
		"question":"Ethan finds a website offering 'free cracked software' and considers downloading it. What risk is he taking?",
		"answers":[
			"A. Getting a faster computer",
			"B. Downloading ransomware or other malware",
			"C. Receiving free official updates",
			"D. Saving money safely"
		],
		"correct_answer": 1
	}
		
]

func _ready() -> void:
	questions.shuffle()
	timer.timeout.connect(_on_timer_timeout)

	# Connect button presses with their index
	button_a.pressed.connect(_on_answer_pressed.bind(0))
	button_b.pressed.connect(_on_answer_pressed.bind(1))
	button_c.pressed.connect(_on_answer_pressed.bind(2))
	button_d.pressed.connect(_on_answer_pressed.bind(3))

	display_question(current_question)

func start_quiz():
	GameManager.ui_active = true
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
		question_counter +=1
		question_counter_label.text = "Question " + str(question_counter) + " of 30"
		score_label.text = "Score: " + str(point_counter)
		timer.start()
		print("✅ Correct!")
	else:
		timer.start()
		question_counter +=1
		question_counter_label.text = "Question " + str(question_counter) + " of 30"
		print("❌ Wrong! Correct answer: " + quiz_item["answers"][quiz_item["correct_answer"]])

	# Move to next question
	current_question += 1
	if current_question < questions.size():
		display_question(current_question)
	else:
		question_counter +=1
		quiz_finished.emit(point_counter)
		print("🎉 Quiz finished! Final Score: ", point_counter)

func _on_timer_timeout() -> void:
	current_question += 1
	if current_question < questions.size():
		display_question(current_question)
	else:
		quiz_finished.emit(point_counter)
		print("⏰ Time’s up! Quiz finished! Final Score: ", point_counter)
