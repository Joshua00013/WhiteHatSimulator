extends Control

@export var quiz_title : Label
@export var question_label : Label
@export var button_a : Button
@export var button_b : Button
@export var button_c : Button
@export var button_d : Button

signal option_btn_pressed

var ransomware_question1 = {
	"question" :  "What is the main goal of a ransomware attack?",
	"optionA" : "A. To secretly spy on internet activity",
	"optionB" : "B. To encrypt files and demand payment",
	"optionC" : "C. To delete all system files permanently",
	"optionD" : "D. To improve computer performance"
}

var ransomware_question2 = {
	"question" :  "Which of the following is the way may ransomware enters a system?",
	"optionA" : "A. Fake emails with attachments or links",
	"optionB" : "B. Downloading system updates",
	"optionC" : "C. Installing antivirus software",
	"optionD" : "D. Using strong passwords"
}


#var ransomware_quiz ={
	#"question_1" : "What is the main goal of a ransomware attack?",
	#"question_2" : "Which of the following is the MOST common way ransomware enters a system?",
	#"question_3" : "What is the main goal of a ransomware attack?",
#}

func _ready():
	print(ransomware_question1["optionA"])
	
