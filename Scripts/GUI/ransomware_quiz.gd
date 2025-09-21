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
	"correct_answer": 2
  },
  {
	"question": "Where does fileless malware keep its code while running?",
	"answers": [
	  "A. In the USB flashdrive",
	  "B. In the RAM",
	  "C. In the downloads folder",
      "D. In the Recycle Bin"
	],
	"correct_answer": 2
  },
  {
	"question": "Which common tool do attackers sometimes use for fileless attacks on Windows?",
	"answers": [
	  "A. Paint",
	  "B. Notepad",
	  "C. PowerShell or system tools",
      "D. Calculator"
	],
	"correct_answer": 3
  },
  {
	"question": "How can you reduce the chance of fileless attacks from email attachments?",
	"answers": [
	  "A. Open every attachment quickly",
	  "B. Save attachments to desktop first",
	  "C. Don't open unknown attachments and disable macros",
      "D. Forward attachments to friends"
	],
	"correct_answer": 3
  },
  {
	"question": "Why should organizations keep software up to date?",
	"answers": [
	  "A. Updates slow down computers",
	  "B. Updates fix holes hackers use for attacks",
	  "C. Updates delete personal files",
      "D. Updates change passwords automatically"
	],
	"correct_answer": 4
  },
  {
	"question": "What tool can be used to listen for a fileless malware connection?",
	"answers": [
	  "A. Task Manager",
	  "B. Metasploit",
	  "C. Notepad",
      "D. WinRAR"
	],
	"correct_answer": 2
  },
  {
	"question": "What does the payload do in fileless malware?",
	"answers": [
	  "A. Shows a warning message",
	  "B. Executes malicious actions in memory",
	  "C. Deletes antivirus",
      "D. Formats the hard drive"
	],
	"correct_answer": 2
  },
  {
	"question": "What is the purpose of shellcode in this type of attack?",
	"answers": [
	  "A. Store pictures in a folder",
	  "B. Store usernames in the database",
	  "C. Store machine instructions that will run in memory",
      "D. Store Wi-Fi passwords in the database"
	],
	"correct_answer": 3
  },
  {
	"question": "Which command creates the raw shellcode we discussed?",
	"answers": [
	  "A. gcc",
	  "B. msfvenom",
	  "C. ifconfig",
      "D. curl"
	],
	"correct_answer": 2
  },
  {
	"question": "What happens when the loader runs?",
	"answers": [
	  "A. It writes the code to a file",
	  "B. It downloads and executes shellcode directly in memory",
	  "C. It restarts the PC",
      "D. It shows an error"
	],
	"correct_answer": 2
  },
  {
	"question": "What is a simple way to block this attack?",
	"answers": [
	  "A. Stop using your PC",
	  "B. Block unknown PowerShell and script executions",
	  "C. Remove RAM from the PC",
      "D. Never open a browser again"
	],
	"correct_answer": 2
  },
  {
	"question": "Why should you check USB drives before running files?",
	"answers": [
	  "A. They may contain memory-only loaders",
	  "B. They may contain music",
	  "C. They make PCs slower",
      "D. They erase Windows"
	],
	"correct_answer": 1
  },
  {
	"question": "Why should you disable autorun on USB drives?",
	"answers": [
	  "A. It prevents loaders from starting automatically",
	  "B. It makes copying files faster",
	  "C. It protects RAM",
      "D. It fixes the registry"
	],
	"correct_answer": 1
  },
  {
	"question": "Why is rebooting sometimes a solution?",
	"answers": [
	  "A. It deletes shellcode from memory",
	  "B. It formats your PC",
	  "C. It downloads more shellcode",
      "D. It disables the internet"
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
	"correct_answer": 2
  },
  {
	"question": "Which of these are ways a payload can get to a victim?",
	"answers": [
	  "A. Downloaded from a malicious application",
	  "B. Installed manually from CD",
	  "C. Through a printer",
      "D. Through a fan"
	],
	"correct_answer": 1
  },
  {
	"question": "You see 'powershell.exe' running with a long, encoded command and the user did not run it. What should you suspect?",
	"answers": [
	  "A. A scheduled wallpaper change",
	  "B. A safe system backup",
	  "C. A fileless script or malicious use of PowerShell",
      "D. A printer driver update"
	],
	"correct_answer": 3
  },
  {
	"question": "How can a malicious file start the attack?",
	"answers": [
	  "A. By opening a fake image",
	  "B. By running a small EXE that loads shellcode",
	  "C. By changing wallpapers",
      "D. By renaming folders"
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
	"correct_answer": 2
  },
  {
	"question": "What command can download shellcode from a hosted server?",
	"answers": [
	  "A. cpr::Get",
	  "B. printf",
	  "C. free",
      "D. copy con"
	],
	"correct_answer": 1
  },
  {
	"question": "What are the 2 most important things you need when creating a reverse shell payload?",
	"answers": [
	  "A. Username & Password",
	  "B. Hostname & Browser",
	  "C. IP Address & Port",
      "D. MAC Address & Gateway"
	],
	"correct_answer": 3
  },
  {
	"question": "What command generates the payload code in Metasploit?",
	"answers": [
	  "A. msfvenom",
	  "B. msfconsole",
	  "C. ifconfig",
      "D. gcc"
	],
	"correct_answer": 1
  },
  {
	"question": "What kind of encoder is commonly used to evade basic antivirus?",
	"answers": [
	  "A. Base64",
	  "B. ROT13",
	  "C. Shikata Ga Nai",
      "D. AES"
	],
	"correct_answer": 3
  },
  {
	"question": "What does the LHOST option represent?",
	"answers": [
	  "A. Victim’s PC",
	  "B. Attacker’s IP Address",
	  "C. Website URL",
      "D. Port Number"
	],
	"correct_answer": 2
  },
  {
	"question": "What does the LPORT option represent?",
	"answers": [
	  "A. Browser",
	  "B. Port to listen for the reverse connection",
	  "C. Wi-Fi password",
      "D. File size"
	],
	"correct_answer": 2
  },
  {
	"question": "What is the output format when using -f c in msfvenom?",
	"answers": [
	  "A. Compiled exe",
	  "B. Python script",
	  "C. C-style shellcode array",
      "D. JSON file"
	],
	"correct_answer": 3
  },
  {
	"question": "Why is the shellcode saved to a .txt file first?",
	"answers": [
	  "A. To run directly",
	  "B. To hide from antivirus",
	  "C. To copy it into a boilerplate program later",
      "D. To share on email"
	],
	"correct_answer": 3
  },
  {
	"question": "What does the boilerplate code do with the shellcode?",
	"answers": [
	  "A. Deletes it",
	  "B. Loads it into memory and executes it",
	  "C. Uploads it to the server",
      "D. Encrypts it"
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
	"question": "What Metasploit command is used to open the listener?",
	"answers": [
	  "A. msfvenom",
	  "B. curl",
	  "C. use exploit/multi/handler",
      "D. ifconfig"
	],
	"correct_answer": 3
  }
]
var day_four_questions = [ #TODO : Insert phishing questions here
		{
		"question":"What is phishing?",
		"answers":[
			"A. A way to speed up internet",
			"B. A trick to steal personal information using fake messages",
			"C. A tool to clean viruses",
			"D. A type of firewall"
		],
		"correct_answer": 2
	},
	{
		"question":"What is the main goal of phishing?",
		"answers":[
			"A. To break your keyboard",
			"B. To get private data like passwords or cards",
			"C. To make your files disappear",
			"D. To slow down your internet"
		],
		"correct_answer": 2
	},
	{
		"question":"Which of these is a common phishing method?",
		"answers":[
			"A. Fake emails that look real",
			"B. Installing PC drivers",
			"C. Burning software CDs",
			"D. Using cheat codes"
		],
		"correct_answer": 1
	},
	{
		"question":"Why is phishing dangerous?",
		"answers":[
			"A. It fills your hard drive",
			"B. It steals personal information secretly",
			"C. It slows your RAM speed",
			"D. It overheats your CPU"
		],
		"correct_answer": 2
	},
	{
		"question":"What do phishing sites usually copy?",
		"answers":[
			"A. Game websites and wallpaper shops",
			"B. Bank, email, or social media pages",
			"C. News websites and blogs",
			"D. Video streaming portals"
		],
		"correct_answer": 2
	},
	{
		"question":"Which of these is NOT phishing?",
		"answers":[
			"A. Fake email asking for password",
			"B. Fake site asking for login",
			"C. Installing a game from DVD",
			"D. QR code that opens fake form"
		],
		"correct_answer": 3
	},
	{
		"question":"If an email says your bank account is locked and asks for your password, what should you do?",
		"answers":[
			"A. Call the bank directly using their official number",
			"B. Reply with your password",
			"C. Click the link right away",
			"D. Forward to all friends"
		],
		"correct_answer": 0
	},
	{
		"question":"What is the best practice to prevent phishing?",
		"answers":[
			"A. Use the same password everywhere",
			"B. Always verify links and senders before clicking or sharing any personal information.",
			"C. Write it on sticky notes",
			"D. Share with friends"
		],
		"correct_answer": 1
	},
	{
		"question":"How do phishing attacks usually reach victims?",
		"answers":[
			"A. Through software updates",
			"B. Through emails with links or files",
			"C. Through Wi-Fi router settings",
			"D. Through Bluetooth devices"
		],
		"correct_answer": 2
	},
	{
		"question":"What should you do if you suspect a phishing site?",
		"answers":[
			"A. Close it and report it",
			"B. Enter fake details",
			"C. Save it for later",
			"D. Share it with friends"
		],
		"correct_answer": 0
	},
	{
		"question":"How do phishing emails trick users?",
		"answers":[
			"A. By playing music",
			"B. By warning account suspension",
			"C. By installing updates",
			"D. By deleting files"
		],
		"correct_answer": 2
	},
	{
		"question":"What happens when you click a phishing link?",
		"answers":[
			"A. Screen turns blue",
			"B. You open a fake login page",
			"C. Your PC shuts down",
			"D. Nothing happens"
		],
		"correct_answer": 2
	},
	{
		"question":"Best way to avoid phishing?",
		"answers":[
			"A. Never use the internet",
			"B. Check the URL before typing login",
			"C. Always click links fast",
			"D. Ignore antivirus alerts"
		],
		"correct_answer": 2
	},
	{
		"question":"What should you do with suspicious emails?",
		"answers":[
			"A. Open links to check them",
			"B. Report to email provider",
			"C. Download all attachments",
			"D. Reply with login info"
		],
		"correct_answer": 2
	},
	{
		"question":"What’s the safest step if unsure about an email?",
		"answers":[
			"A. Ignore security warnings",
			"B. Click and see what happens",
			"C. Share on social media",
			"D. Verify with the real company directly"
		],
		"correct_answer": 3
	},
	{
		"question":"Safe way to access bank account?",
		"answers":[
			"A. Manually type official bank URL",
			"B. Click random links",
			"C. Use QR codes from strangers",
			"D. Ask someone for link"
		],
		"correct_answer": 1
	},
	{
		"question":"John receives a message from 'banksecurity@gmail.com' asking for his login. What’s the safe step?",
		"answers":[
			"A. Ignore and report it",
			"B. Enter his password",
			"C. Forward it to friends",
			"D. Save it for later"
		],
		"correct_answer": 0
	},
	{
		"question":"What happens if you fall for phishing?",
		"answers":[
			"A. PC becomes faster",
			"B. Login credentials are stolen",
			"C. Hard disk repairs itself",
			"D. You get free games"
		],
		"correct_answer": 2
	},
	
	{
		"question":"Can phishing lead to ransomware?",
		"answers":[
			"A. No",
			"B. Yes, often",
			"C. Only on phones",
			"D. Only on Linux"
		],
		"correct_answer": 2
	},
	{
		"question":"A fake website looks almost like Facebook. How can Alex notice it’s fake?",
		"answers":[
			"A. By looking at the color",
			"B. By checking the website address (URL)",
			"C. By the number of ads",
			"D. By how fast it loads"
		],
		"correct_answer": 1
	},
	{
		"question":"Sarah receives a job offer email but it asks her to pay a fee first. What’s correct?",
		"answers":[
			"A. Real jobs don’t ask for money upfront",
			"B. It’s normal practice",
			"C. It’s always safe",
			"D. She should pay quickly"
		],
		"correct_answer": 0
	},
	{
		"question":"Tom gets a warning email saying his account will be closed in 1 hour unless he clicks. What’s this?",
		"answers":[
			"A. A safe offer",
			"B. A real system update",
			"C. A phishing scam using urgency",
			"D. An email from a friend"
		],
		"correct_answer": 2
	},
	{
		"question":"Nina receives a file from an unknown sender. What should she do?",
		"answers":[
			"A. Don’t open it and delete it",
			"B. Open quickly",
			"C. Send it to friends",
			"D. Trust it"
		],
		"correct_answer": 0
	},
	{
		"question":"A message says: 'Confirm your password to continue using email.' What should Ben do?",
		"answers":[
			"A. Ignore security rules",
			"B. Type it quickly",
			"C. Share it with friends",
			"D. Never type his password into such links"
		],
		"correct_answer": 3
	},
	{
		"question":"Olivia gets a mail with 'Click here for free gift card.' What’s the right step?",
		"answers":[
			"A. Click the link fast",
			"B. Delete and report the email",
			"C. Share with family",
			"D. Save it"
		],
		"correct_answer": 1
	},
	{
		"question":"David receives an email from his school but the email domain looks strange. What should he think?",
		"answers":[
			"A. It’s always safe",
			"B. It’s 100% real",
			"C. It could be phishing; verify it directly with the school",
			"D. It’s a free bonus"
		],
		"correct_answer": 2
	},
	{
		"question":"An email says: 'Update your payment now by clicking here.' What’s safest?",
		"answers":[
			"A. Go directly to the real company’s website",
			"B. Click the link in the email",
			"C. Forward to friends",
			"D. Reply with credit card info"
		],
		"correct_answer": 0
	},
	{
		"question":"Sophia gets an email prize but must log in with her Gmail account. What’s correct?",
		"answers":[
			"A. It’s a phishing trick to steal Gmail login",
			"B. It’s a real prize",
			"C. It’s normal",
			"D. It’s always safe"
		],
		"correct_answer": 0
	},
	{
		"question":"What should Kevin do if unsure about a message?",
		"answers":[
			"A. Reply quickly",
			"B. Trust the email fully",
			"C. Share it online",
			"D. Verify with the company using official contacts"
		],
		"correct_answer": 3
	}
]
var day_five_questions = [ #TODO : Insert DOS questions here
	  {
		"question":"What is a DoS attack?",
		"answers":[
			"A. A way to fix broken servers",
			"B. A method to overload and stop a service",
			"C. A tool to boost internet speed",
			"D. A type of antivirus scan"
		],
		"correct_answer": 2
	},
  {
	"question": "Which sign shows a site may be under a DoS attack?",
	"answers": [
	  "A. The site becomes slow or does not load",
	  "B. The site sends a welcome email",
	  "C. The site changes its logo",
      "D. The site gets more posts"
	],
	"correct_answer": 0
  },
  {
		"question":"What does DDoS stand for?",
		"answers":[
			"A. Distributed Denial of Service",
			"B. Direct Data Output System",
			"C. Distributed Disk Operating System",
			"D. Data Delivery Over Socket"
		],
		"correct_answer": 1
	},				
 {
		"question":"Which network layer is often targeted by DoS attacks?",
		"answers":[
			"A. Physical layer",
			"B. Transport or Application layer",
			"C. Presentation layer",
			"D. Data link layer"
		],
		"correct_answer": 2
	},
  {
		"question":"What is the goal of a DoS attack?",
		"answers":[
			"A. To make a website unavailable for users",
			"B. To steal passwords",
			"C. To install drivers",
			"D. To update software"
		],
		"correct_answer": 1
	},
  {
		"question":"Which of these is a symptom of a DoS attack?",
		"answers":[
			"A. Slower network response",
			"B. Faster website loading",
			"C. Increased CPU temperature only",
			"D. Reduced RAM usage"
		],
		"correct_answer": 1
	},
  
  {
		"question":"Which protocol is commonly abused in DoS floods?",
		"answers":[
			"A. SMTP",
			"B. HTTP or TCP",
			"C. DNS only",
			"D. POP3"
		],
		"correct_answer": 2
	},
  {
		"question":"What can be a target of a DoS attack?",
		"answers":[
			"A. Websites, game servers, APIs",
			"B. USB flash drives",
			"C. RAM chips",
			"D. Keyboard drivers"
		],
		"correct_answer": 1
	},
  {
		"question":"How does a DDoS attack typically start?",
		"answers":[
			"A. By infecting many devices with malware",
			"B. By installing a single driver",
			"C. By using a firewall update",
			"D. By removing internet connection"
		],
		"correct_answer": 1
	},
  {
		"question":"What should you avoid clicking to stay safe?",
		"answers":[
			"A. Random scripts that run floods",
			"B. Safe official pages",
			"C. Browser refresh button",
			"D. Search bar"
		],
		"correct_answer": 1
	},
  {
		"question":"What is one way to mitigate DoS attacks?",
		"answers":[
			"A. Use load balancers or firewalls",
			"B. Turn off antivirus",
			"C. Disconnect router permanently",
			"D. Use free public Wi-Fi"
		],
		"correct_answer": 1
	},
  {
		"question":"Which is a good practice to prevent DoS?",
		"answers":[
			"A. Rate limiting requests per IP",
			"B. Allow unlimited requests",
			"C. Disable firewall",
			"D. Use default passwords"
		],
		"correct_answer": 1
	},
  {
		"question":"What should be monitored to detect DoS early?",
		"answers":[
			"A. Network traffic spikes",
			"B. Screen brightness",
			"C. Keyboard usage",
			"D. Mouse clicks"
		],
		"correct_answer": 1
	},

  {
	"question": "Your school website becomes very slow for everyone. What is the most likely cause?",
	"answers": [
	  "A. A printer jam",
	  "B: A huge DoS attack flooding the site",
	  "C: A staff meeting",
      "D: A change in font settings"
	],
	"correct_answer": 1
  },
  {
	"question": "Many users report the site is down, but the server is running. What should you check first?",
	"answers": [
	  "A. If the staff calendar has events",
	  "B. If the coffee machine is working",
	  "C. If the office lights are on",
      "D. If there is an unusual spike in incoming traffic"
	],
	"correct_answer": 3
  },
  {
		"question":"What is an IP address used for in a stress test?",
		"answers":[
			"A. To find and target the server",
			"B. To speed up browser cache",
			"C. To update firewall rules",
			"D. To hide PC temperature"
		],
		"correct_answer": 1
	},
  {
	"question": "A website slows down only when users try to search. Which targeted DoS defense could help?",
	"answers": [
	  "A. Add caching and rate-limits on the search endpoint",
	  "B. Delete the search feature permanently",
	  "C. Make the search require a phone call",
      "D. Disable images on the site"
	],
	"correct_answer": 0
  },
  {
		"question":"Which parameter controls attack duration?",
		"answers":[
			"A. Timeout",
			"B. IP",
			"C. Threads",
			"D. URL"
		],
		"correct_answer": 1
	},
  {
		"question":"What does choosing HTTP as a method do?",
		"answers":[
			"A. Sends floods using web requests",
			"B. Shuts down TCP connection",
			"C. Deletes server logs",
			"D. Blocks DNS lookups"
		],
		"correct_answer": 1
	},
  {
		"question":"Why set subtitle as '/' in HTTP flood?",
		"answers":[
			"A. To target the main page root",
			"B. To attack images only",
			"C. To change the IP",
			"D. To skip DNS resolution"
		],
		"correct_answer": 1
	},
  {
	"question": "An attacker targets your API with many valid-looking requests to overload the database. What helps most?",
	"answers": [
	  "A. Add caching, request validation, and per-user throttling",
	  "B. Remove authentication from the API",
	  "C. Allow unlimited requests",
      "D. Move the API to a personal laptop"
	],
	"correct_answer": 0
  },
  {
	"question": "You see a sudden flood of traffic from IPs in one country. What short-term action can reduce impact?",
	"answers": [
	  "A. Change the company logo",
	  "B. Open more ports",
	  "C. Delete the server",
      "D. Block or rate-limit that country’s IPs while investigating"
	],
	"correct_answer": 3
  },
  {
	"question": "A competitor is suspected of launching intermittent small attacks to damage your service. What long-term step is useful?",
	"answers": [
	  "A. Work with your ISP, gather evidence, and strengthen mitigation plans",
	  "B. Sue immediately without proof",
	  "C. Hide the problem forever",
      "D. Give the competitor admin access"
	],
	"correct_answer": 0
  },
  {
	"question": "Your DNS provider is under attack and your domain cannot be resolved. What redundancy helps most?",
	"answers": [
	  "A. Change domain daily",
	  "B. Keep only one DNS provider and hope",
	  "C. Turn off DNS entirely",
      "D. Use multiple authoritative DNS providers and failover"
	],
	"correct_answer": 3
  },
  {
	"question": "A test caused a DoS in production by mistake. What policy could have prevented this?",
	"answers": [
	  "A. Isolated test environments and approved load testing",
	  "B. Running all tests directly in production",
	  "C. No testing at all",
      "D. Letting anyone run unlimited load tests"
	],
	"correct_answer": 0
  }
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
	#_shuffle_answers_for_questions(active_questions)
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
		question_counter_label.text = "Question " + str(question_counter) + " of 10"
		score_label.text = "Score: " + str(point_counter)
		timer.start()
		print("✅ Correct!")
	else:
		timer.start()
		question_counter +=1
		question_counter_label.text = "Question " + str(question_counter) + " of 10"
		print("❌ Wrong! Correct answer: " + quiz_item["answers"][quiz_item["correct_answer"]])

	# Move to next question
	current_question += 1
	if current_question < 10:
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
		

#func _question_counter_checker(question_count: int):
	#if question_count == 10:
		#print("Quiz finish")
				#
#func _pick_random_questions(source: Array, count: int) -> Array:
	#var copy = source.duplicate()
	#copy.shuffle()
	#return copy.slice(0, min(count, copy.size()))
#
#func _shuffle_answers_for_questions(questions: Array) -> void:
	#for item in questions:
		#var correct_text = item["answers"][item["correct_answer"]]
		#var answers_copy = item["answers"].duplicate()
		#answers_copy.shuffle()
		#item["answers"] = answers_copy
		#item["correct_answer"] = answers_copy.find(correct_text)
