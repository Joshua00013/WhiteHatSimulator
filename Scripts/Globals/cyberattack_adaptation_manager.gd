extends Node

var flashdrive_used := false
var email_used := false

var weak_passwords := true
var no_password_used := true

var sharing_passwords_used := false
var noting_passwords := false
var tailgating_used := false
var job_application_used := false
var unattended_pc_used := false

var bruteforce_used := false
var phishing_used := false

var antivirus_installed := false
var antivirus_updated := false

func reset():
	flashdrive_used = false
	email_used = false
	
	weak_passwords = true
	no_password_used = true
	
	sharing_passwords_used = false
	noting_passwords = false
	tailgating_used = false
	job_application_used = false
	unattended_pc_used = false

	bruteforce_used = false
	phishing_used = false

	antivirus_installed = false
	antivirus_updated = false
