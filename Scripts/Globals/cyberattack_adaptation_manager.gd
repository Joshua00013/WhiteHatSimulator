extends Node

var flashdrive_used: bool = false : set = set_flashdrive_used
var email_used: bool = false : set = set_email_used

var weak_passwords: bool = true : set = set_weak_passwords
var no_password_used: bool = true : set = set_no_password_used

var sharing_passwords_used: bool = false : set = set_sharing_passwords_used
var noting_passwords: bool = false : set = set_noting_passwords
var tailgating_used: bool = false : set = set_tailgating_used
var job_application_used: bool = false : set = set_job_application_used
var unattended_pc_used: bool = false : set = set_unattended_pc_used
var bruteforce_used: bool = false : set = set_bruteforce_used
var phishing_used: bool = false : set = set_phishing_used

var antivirus_installed: bool = false : set = set_antivirus_installed
var antivirus_updated: bool = false : set = set_antivirus_updated


# Temporary values (during stage)
var _temp_flashdrive_used := false
var _temp_email_used := false

var _temp_weak_passwords := true
var _temp_no_password_used := true

var _temp_sharing_passwords_used := false
var _temp_noting_passwords := false
var _temp_tailgating_used := false
var _temp_job_application_used := false
var _temp_unattended_pc_used := false
var _temp_bruteforce_used := false
var _temp_phishing_used := false
var _temp_antivirus_installed := false
var _temp_antivirus_updated := false


# --- Setters redirect to temporary ---
func set_flashdrive_used(val):
	if GameManager.stage_finished == false:
		_temp_flashdrive_used = val
	else:
		flashdrive_used = val

func set_email_used(val):
	if GameManager.stage_finished == false:
		_temp_email_used = val
	else:
		email_used = val

func set_weak_passwords(val):
	if GameManager.stage_finished == false:
		_temp_weak_passwords = val
	else:
		weak_passwords = val

func set_no_password_used(val):
	if GameManager.stage_finished == false:
		_temp_no_password_used = val
	else:
		no_password_used = val

func set_sharing_passwords_used(val):
	if GameManager.stage_finished == false:
		_temp_sharing_passwords_used = val
	else:
		sharing_passwords_used = val

func set_noting_passwords(val):
	if GameManager.stage_finished == false:
		_temp_noting_passwords = val
	else:
		noting_passwords = val

func set_tailgating_used(val):
	if GameManager.stage_finished == false:
		_temp_tailgating_used = val
	else:
		tailgating_used = val

func set_job_application_used(val):
	if GameManager.stage_finished == false:
		_temp_job_application_used = val
	else:
		job_application_used = val

func set_unattended_pc_used(val):
	if GameManager.stage_finished == false:
		_temp_unattended_pc_used = val
	else:
		unattended_pc_used = val

func set_bruteforce_used(val):
	if GameManager.stage_finished == false:
		_temp_bruteforce_used = val
	else:
		bruteforce_used = val

func set_phishing_used(val):
	if GameManager.stage_finished == false:
		_temp_phishing_used = val
	else:
		phishing_used = val

func set_antivirus_installed(val):
	if GameManager.stage_finished == false:
		_temp_antivirus_installed = val
	else:
		antivirus_installed = val

func set_antivirus_updated(val):
	if GameManager.stage_finished == false:
		_temp_antivirus_updated = val
	else:
		antivirus_updated = val


# --- Called at end of stage ---
func finalize_stage():
	flashdrive_used = _temp_flashdrive_used
	email_used = _temp_email_used
	weak_passwords = _temp_weak_passwords
	no_password_used = _temp_no_password_used
	
	print("Weak passwords:" + str(weak_passwords))
	print("No passwords:" + str(no_password_used))
	sharing_passwords_used = _temp_sharing_passwords_used
	noting_passwords = _temp_noting_passwords
	tailgating_used = _temp_tailgating_used
	job_application_used = _temp_job_application_used
	unattended_pc_used = _temp_unattended_pc_used
	bruteforce_used = _temp_bruteforce_used
	phishing_used = _temp_phishing_used
	antivirus_installed = _temp_antivirus_installed
	antivirus_updated = _temp_antivirus_updated


# --- Reset temp values ---
func reset_temp():
	_temp_flashdrive_used = false
	_temp_email_used = false
	_temp_weak_passwords = true
	_temp_no_password_used = true
	_temp_sharing_passwords_used = false
	_temp_noting_passwords = false
	_temp_tailgating_used = false
	_temp_job_application_used = false
	_temp_unattended_pc_used = false
	_temp_bruteforce_used = false
	_temp_phishing_used = false
	_temp_antivirus_installed = false
	_temp_antivirus_updated = false

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
	
	reset_temp()
