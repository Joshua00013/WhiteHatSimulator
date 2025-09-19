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
# Unused array of all questions
#var questions = []

var day_one_questions = [ #TODO : Insert ransomware questions here
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
var day_two_questions = [ #TODO : Insert bruteforce questions here
	 {
	"question": "What is a brute force attack?",
	"answers": [
	  "A. Asking nicely for the password",
	  "B. Guessing passwords by trying many combinations",
	  "C. Writing the password in a notebook",
      "D. Asking IT support for the password"
	],
	"correct_answer": 1
  },
  {
	"question": "Why do hackers use brute force attacks?",
	"answers": [
	  "A. To make friends",
	  "B. To steal personal information's and passwords",
	  "C. To fix your computer",
      "D. To slow the internet"
	],
	"correct_answer": 1
  },
  {
	"question": "Which password is easiest to break with brute force?",
	"answers": [
	  "A. 1234",
	  "B. Pa$$w0rd!X9",
	  "C. mySecretKey123",
      "D. qWeRTy$7K!"
	],
	"correct_answer": 0
  },
  {
	"question": "Which password is strongest?",
	"answers": [
	  "A. dog",
	  "B. 12345",
	  "C. MyD0gL0vesB0nes!",
      "D. password"
	],
	"correct_answer": 2
  },
  {
	"question": "How can you prevent brute force attacks?",
	"answers": [
	  "A. Use long, strong passwords",
	  "B. Share your password",
	  "C. Use “123456” for memory",
      "D. Avoid using a password"
	],
	"correct_answer": 0
  },
  {
	"question": "What does two-step verification do?",
	"answers": [
	  "A. Requires a second code (like SMS) after the password",
	  "B. Deletes your password",
	  "C. Makes login slower",
      "D. Lets friends log in for you"
	],
	"correct_answer": 0
  },
  {
	"question": "Why is using the same password for many accounts risky?",
	"answers": [
	  "A. Hackers can break into all accounts if one password is stolen",
	  "B. It’s harder to remember",
	  "C. It costs money",
      "D. It makes login faster"
	],
	"correct_answer": 0
  },
  {
	"question": "What happens in a brute force attack if your password is short?",
	"answers": [
	  "A. Hackers guess it quickly",
	  "B. Hackers get tired",
	  "C. Hackers quit",
      "D. Hackers fail"
	],
	"correct_answer": 0
  },
  {
	"question": "Which is safer?",
	"answers": [
	  "A. A password with only numbers",
	  "B. A password with letters, numbers, and symbols",
	  "C. A 4-letter word",
      "D. Your birthday"
	],
	"correct_answer": 1
  },
  {
	"question": "What tool do hackers often use for brute force?",
	"answers": [
	  "A. Automated password-guessing programs",
	  "B. Pencils and paper",
	  "C. Phone calls",
      "D. Notebooks"
	],
	"correct_answer": 0
  },
  {
	"question": "Why are account lockouts helpful?",
	"answers": [
	  "A. They stop hackers from guessing endless passwords",
	  "B. They make users angry",
	  "C. They slow your typing",
      "D. They save electricity"
	],
	"correct_answer": 0
  },
  {
	"question": "How often should you change your password to be safe?",
	"answers": [
	  "A. Regularly, every few months",
	  "B. Never",
	  "C. Only if you feel like it",
      "D. Once in your life"
	],
	"correct_answer": 0
  },
  {
	"question": "Which password should you avoid?",
	"answers": [
	  "A. My!D0g1234House",
	  "B. 987654",
	  "C. $C00lP@ss2025",
      "D. Safe#LockX7"
	],
	"correct_answer": 1
  },
  {
	"question": "How can companies fight brute force attacks?",
	"answers": [
	  "A. Limit login attempts and use CAPTCHAs",
	  "B. Remove passwords",
	  "C. Allow unlimited tries",
      "D. Use short PIN codes"
	],
	"correct_answer": 0
  },
  {
	"question": "Why should you not use personal details (like birthday) as passwords?",
	"answers": [
	  "A. They are easy for hackers to guess",
	  "B. They take too long to type",
	  "C. They are expensive",
      "D. They cannot be remembered"
	],
	"correct_answer": 0
  },
  {
	"question": "John keeps trying 200 different passwords to enter his friend’s email. What is he doing?",
	"answers": [
	  "A. Fileless attack",
	  "B. Phishing attack",
	  "C. Brute force attack",
      "D. DoS attack"
	],
	"correct_answer": 2
  },
  {
	"question": "Maria uses “12345” as her password. A hacker cracks it in seconds. Why?",
	"answers": [
	  "A. The hacker sent her an email",
	  "B. The hacker overloaded the website",
	  "C. The password was too simple",
      "D. The hacker installed a virus"
	],
	"correct_answer": 2
  },
  {
	"question": "A bank locks you out after 5 wrong login tries. What is this stopping?",
	"answers": [
	  "A. Phishing",
	  "B. Brute force attack",
	  "C. Fileless attack",
      "D. Email spam"
	],
	"correct_answer": 1
  },
  {
	"question": "A hacker uses a program that tests thousands of passwords every second. What attack is this?",
	"answers": [
	  "A. Phishing attack",
	  "B. DoS attack",
	  "C. Brute force attack",
      "D. Spyware attack"
	],
	"correct_answer": 2
  },
  {
	"question": "You add numbers and symbols to your password. What attack are you preventing?",
	"answers": [
	  "A. Fileless",
	  "B. DoS",
	  "C. Brute force attack",
      "D. Phishing"
	],
	"correct_answer": 2
  },
  {
	"question": "A student’s account is safe because it requires a code sent to their phone after login. What protection is this?",
	"answers": [
	  "A. Fileless",
	  "B. DoS",
	  "C. Phishing",
      "D. Two-step verification against brute force"
	],
	"correct_answer": 3
  },
  {
	"question": "Hackers fail to guess Anna’s password because it has 15 characters with mixed symbols. Why?",
	"answers": [
	  "A. She used phishing prevention",
	  "B. She avoided fileless attacks",
	  "C. Password was too strong for brute force",
      "D. She blocked DoS"
	],
	"correct_answer": 2
  },
  {
	"question": "A school account gets hacked because the password was “school123.” What happened?",
	"answers": [
	  "A. The student clicked a phishing link",
	  "B. The system crashed from DoS",
	  "C. Easy password guessed by brute force",
      "D. A fileless virus attacked it"
	],
	"correct_answer": 2
  },
  {
	"question": "A company uses CAPTCHA after 3 wrong tries. What does this block?",
	"answers": [
	  "A. Phishing emails",
	  "B. Brute force attacks",
	  "C. Viruses",
      "D. DoS attacks"
	],
	"correct_answer": 1
  },
  {
	"question": "A hacker spends hours typing in random words until one works. What is this called?",
	"answers": [
	  "A. DoS attack",
	  "B. Phishing",
	  "C. Fileless",
      "D. Brute force attack"
	],
	"correct_answer": 3
  },
  {
	"question": "John’s password is “ILOVEpizza#2025!!” Hackers give up. Why?",
	"answers": [
	  "A. DoS blocked them",
	  "B. Fileless didn’t work",
	  "C. Password was too strong for brute force",
      "D. It was phishing-safe"
	],
	"correct_answer": 2
  },
  {
	"question": "Your account is locked after too many failed logins. What attack was stopped?",
	"answers": [
	  "A. Phishing",
	  "B. DoS",
	  "C. Fileless",
      "D. Brute force attack"
	],
	"correct_answer": 3
  },
  {
	"question": "Maria uses the same password for school, email, and games. A hacker gets into all three. Why?",
	"answers": [
	  "A. The attacker used phishing",
	  "B. Same password used everywhere",
	  "C. A fileless attack",
      "D. A DoS flood"
	],
	"correct_answer": 1
  },
  {
	"question": "A login system allows unlimited wrong tries. What attack could happen?",
	"answers": [
	  "A. Phishing",
	  "B. Fileless",
	  "C. DoS",
      "D. Brute force attack"
	],
	"correct_answer": 3
  },
  {
	"question": "Hackers fail to guess a student’s password because the account needed fingerprint login. What is this?",
	"answers": [
	  "A. Fileless prevention",
	  "B. DoS prevention",
	  "C. Phishing prevention",
      "D. Extra security against brute force"
	],
	"correct_answer": 3
  }
]
var day_three_questions = [ #TODO : Insert Filelss questions here
	{
	"question": "What is fileless malware?",
	"answers": [
	  "A. A virus that only uses USB drives",
	  "B. Malware that runs in memory or uses regular tools without saving files",
	  "C. A program that deletes files only",
      "D. A harmless app"
	],
	"correct_answer": 1
  },
  {
	"question": "Why is fileless malware harder to find?",
	"answers": [
	  "A. It always turns the screen blue",
	  "B. It does not leave normal files for antivirus to scan",
	  "C. It needs a floppy disk",
      "D. It only attacks printers"
	],
	"correct_answer": 1
  },
  {
	"question": "Which common tool do attackers sometimes use for fileless attacks on Windows?",
	"answers": [
	  "A. Paint",
	  "B. Notepad",
	  "C. PowerShell or system tools",
      "D. Calculator"
	],
	"correct_answer": 2
  },
  {
	"question": "How can you reduce the chance of fileless attacks from email attachments?",
	"answers": [
	  "A. Open every attachment quickly",
	  "B. Save attachments to desktop first",
	  "C. Don't open unknown attachments and disable macros",
      "D. Forward attachments to friends"
	],
	"correct_answer": 2
  },
  {
	"question": "Why should organizations keep software up to date?",
	"answers": [
	  "A. Updates slow down computers",
	  "B. Updates fix holes hackers use for attacks",
	  "C. Updates delete personal files",
      "D. Updates change passwords automatically"
	],
	"correct_answer": 1
  },
  {
	"question": "What does 'least privilege' mean for stopping fileless attacks?",
	"answers": [
	  "A. Give everyone admin access",
	  "B. Give each account only the access it needs",
	  "C. Share passwords among users",
      "D. Disable accounts permanently"
	],
	"correct_answer": 1
  },
  {
	"question": "How does application whitelisting help?",
	"answers": [
	  "A. It allows any program to run",
	  "B. It only allows approved programs to run, blocking unknown scripts",
	  "C. It removes all security warnings",
      "D. It formats the drive daily"
	],
	"correct_answer": 1
  },
  {
	"question": "What logging helps detect fileless attacks?",
	"answers": [
	  "A. Wallpaper change logs",
	  "B. PowerShell, system command, and process activity logs",
	  "C. Printer queue history",
      "D. Font installation logs"
	],
	"correct_answer": 1
  },
  {
	"question": "Why avoid running unsigned scripts from the internet?",
	"answers": [
	  "A. They are always slow",
	  "B. They might contain hidden harmful code",
	  "C. They improve performance",
      "D. They only work on weekends"
	],
	"correct_answer": 1
  },
  {
	"question": "How does removing local admin rights help?",
	"answers": [
	  "A. It stops users from saving files",
	  "B. It stops attackers from running powerful actions easily",
	  "C. It deletes user accounts",
      "D. It speeds up the computer"
	],
	"correct_answer": 1
  },
  {
	"question": "Why is backing up important after a fileless attack?",
	"answers": [
	  "A. Backups only save pictures",
	  "B. Backups let you restore clean systems if needed",
	  "C. Backups stop attacks instantly",
      "D. Backups slow the network"
	],
	"correct_answer": 1
  },
  {
	"question": "What is a simple step users can take to avoid fileless threats?",
	"answers": [
	  "A. Click any link labeled 'update'",
	  "B. Be cautious with links and only install software from trusted sources",
	  "C. Share software installs in chat groups",
      "D. Disable antivirus"
	],
	"correct_answer": 1
  },
  {
	"question": "Which tool helps spot in-memory threats better than basic antivirus?",
	"answers": [
	  "A. Calculator app",
	  "B. Endpoint detection and response (EDR) or behavior monitoring",
	  "C. Paint program",
      "D. Disk defragmenter"
	],
	"correct_answer": 1
  },
  {
	"question": "What should IT do if they find a suspicious script running?",
	"answers": [
	  "A. Ignore it and wait",
	  "B. Isolate the computer and investigate immediately",
	  "C. Post it on social media",
      "D. Turn off all logging"
	],
	"correct_answer": 1
  },
  {
	"question": "Why is training staff useful against fileless attacks?",
	"answers": [
	  "A. Training wastes time",
	  "B. Staff who know the risks are less likely to run unknown scripts or attachments",
	  "C. Training removes malware automatically",
      "D. Training reduces internet speed"
	],
	"correct_answer": 1
  },
  {
	"question": "Maria opens a Word file and enables macros. Minutes later, the computer starts contacting strange servers but no new files appear. What likely happened?",
	"answers": [
	  "A. A printer jam occurred",
	  "B. A normal update ran",
	  "C. A fileless attack ran code in memory via macros",
      "D. The screen saver started"
	],
	"correct_answer": 2
  },
  {
	"question": "You see 'powershell.exe' running with a long, encoded command and the user did not run it. What should you suspect?",
	"answers": [
	  "A. A scheduled wallpaper change",
	  "B. A safe system backup",
	  "C. A fileless script or malicious use of PowerShell",
      "D. A printer driver update"
	],
	"correct_answer": 2
  },
  {
	"question": "An admin tool that normally runs as a trusted program starts opening web connections to unknown sites. No new files are on disk. What is likely happening?",
	"answers": [
	  "A. The tool is updating normally",
	  "B. The internet is slow today",
	  "C. A trusted process is abused by fileless malware",
      "D. The monitor brightness changed"
	],
	"correct_answer": 2
  },
  {
	"question": "A computer shows odd command-line activity but an antivirus scan finds nothing. What is the next best step?",
	"answers": [
	  "A. Reboot and ignore it",
	  "B. Collect memory/EDR logs and investigate for fileless activity",
	  "C. Delete the user account without checking",
      "D. Reinstall printer drivers"
	],
	"correct_answer": 1
  },
  {
	"question": "John received an email with a link. He clicked and a script ran inside the browser, stealing some info without leaving files. What attack type is this?",
	"answers": [
	  "A. A normal website visit",
	  "B. A DoS attack",
	  "C. A fileless attack using browser memory",
      "D. Phishing only"
	],
	"correct_answer": 2
  },
  {
	"question": "An attacker used 'certutil' to download remote content and execute it without saving files. Which defense could have stopped this?",
	"answers": [
	  "A. Allowing all downloads",
	  "B. Disabling logging",
	  "C. Restricting or monitoring use of system tools like certutil",
      "D. Increasing screen resolution"
	],
	"correct_answer": 2
  },
  {
	"question": "A helpdesk script runs with high privileges and is stored unsigned. An attacker uses it to run code in memory. What should the org do to prevent this?",
	"answers": [
	  "A. Share the script more widely",
	  "B. Remove helpdesk tools completely",
	  "C. Require scripts to be signed and run with limited rights",
      "D. Give all users admin rights"
	],
	"correct_answer": 2
  },
  {
	"question": "A server shows many WMI events invoking strange commands. No malware files found. What is likely taking place?",
	"answers": [
	  "A. Normal backup logs",
	  "B. Printer policies being applied",
	  "C. Fileless persistence using WMI",
      "D. A browser cache clear"
	],
	"correct_answer": 2
  },
  {
	"question": "Sally downloads a tool from an unknown site and runs it; it runs only in memory and hides. How could she have avoided this?",
	"answers": [
	  "A. Download from more sites",
	  "B. Always run unknown tools as admin",
	  "C. Only download tools from trusted sources and verify signatures",
      "D. Disable the firewall permanently"
	],
	"correct_answer": 2
  },
  {
	"question": "A company wants to be sure that only approved programs run. What control helps most?",
	"answers": [
	  "A. Let everyone install apps",
	  "B. Use application whitelisting (only approved apps run)",
	  "C. Block all internet access forever",
      "D. Allow unsigned apps from friends"
	],
	"correct_answer": 1
  },
  {
	"question": "An attacker uses PowerShell to load a .NET payload in memory. Which monitoring would catch this?",
	"answers": [
	  "A. Printer queue size logs",
	  "B. PowerShell command logging and EDR alerts",
	  "C. Wallpaper change alerts",
      "D. Disk cleanup history"
	],
	"correct_answer": 1
  },
  {
	"question": "A laptop shows scheduled tasks that download and run code but create no files. What is the best immediate action?",
	"answers": [
	  "A. Reboot the laptop and forget it",
	  "B. Isolate the laptop from the network and investigate the scheduled tasks",
	  "C. Uninstall the web browser",
      "D. Change desktop theme"
	],
	"correct_answer": 1
  },
  {
	"question": "Your company blocks unsigned macros but a user enabled macros to view a document. What risk did they accept?",
	"answers": [
	  "A. Faster document loading",
	  "B. Better video quality",
	  "C. They allowed a possible fileless macro to run",
      "D. More disk space"
	],
	"correct_answer": 2
  },
  {
	"question": "A fileless attack used a legitimate admin account to spread. Which long-term change helps most?",
	"answers": [
	  "A. Give every user admin rights",
	  "B. Remove all user accounts",
	  "C. Restrict admin use and require separate service accounts with strict controls",
      "D. Publish admin passwords internally"
	],
	"correct_answer": 2
  },
  {
	"question": "You detect many hosts running similar base64 PowerShell commands pulled from the same URL. What is the likely situation?",
	"answers": [
	  "A. A normal scheduled update for everyone",
	  "B. A classroom exercise",
	  "C. A coordinated fileless campaign needing immediate containment",
      "D. A harmless script for wallpapers"
	],
	"correct_answer": 2
  }
]
var day_four_questions = [ #TODO : Insert phishing questions here
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
]
var day_five_questions = [ #TODO : Insert DOS questions here
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
]
var active_questions = [] # Store the questions here to be used consistently throughout the whole code. 

func _ready() -> void:
	timer.timeout.connect(_on_timer_timeout)

	# Connect button presses with their index
	button_a.pressed.connect(_on_answer_pressed.bind(0))
	button_b.pressed.connect(_on_answer_pressed.bind(1))
	button_c.pressed.connect(_on_answer_pressed.bind(2))
	button_d.pressed.connect(_on_answer_pressed.bind(3))
	
	match DayAndNightManager.initial_day:
		1:
			active_questions = day_one_questions
		2:
			active_questions = day_two_questions
		3:
			active_questions = day_three_questions
		4:
			active_questions = day_four_questions
		5:
			active_questions = day_five_questions
	
	active_questions.shuffle()
	display_question(current_question)

func start_quiz():
	GameManager.ui_active = true
	timer.start()

func _physics_process(_delta: float) -> void:
	timer_label.text = str(timer.time_left)

func display_question(array_number: int) -> void:
	if array_number < active_questions.size():
		var quiz_item = active_questions[array_number]
		question_label.text = quiz_item["question"]

		var answers = quiz_item["answers"]
		button_a.text = answers[0]
		button_b.text = answers[1]
		button_c.text = answers[2]
		button_d.text = answers[3]

func _on_answer_pressed(answer_index: int) -> void:
	var quiz_item = active_questions[current_question]

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
	if current_question < active_questions.size():
		display_question(current_question)
	else:
		question_counter +=1
		quiz_finished.emit(point_counter)
		print("🎉 Quiz finished! Final Score: ", point_counter)

func _on_timer_timeout() -> void:
	current_question += 1
	if current_question < active_questions.size():
		display_question(current_question)
	else:
		quiz_finished.emit(point_counter)
		print("⏰ Time’s up! Quiz finished! Final Score: ", point_counter)
