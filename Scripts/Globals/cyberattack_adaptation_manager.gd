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

# --- Setters redirect to temporary ---
func set_flashdrive_used(val):
	await SignalBus.stage_finished
	flashdrive_used = val

func set_email_used(val):
	await SignalBus.stage_finished
	email_used = val

func set_weak_passwords(val):
	await SignalBus.stage_finished
	weak_passwords = val

func set_no_password_used(val):
	await SignalBus.stage_finished
	no_password_used = val

func set_sharing_passwords_used(val):
	await SignalBus.stage_finished
	sharing_passwords_used = val

func set_noting_passwords(val):
	await SignalBus.stage_finished
	noting_passwords = val

func set_tailgating_used(val):
	await SignalBus.stage_finished
	tailgating_used = val

func set_job_application_used(val):
	await SignalBus.stage_finished
	job_application_used = val

func set_unattended_pc_used(val):
	await SignalBus.stage_finished
	unattended_pc_used = val

func set_bruteforce_used(val):
	await SignalBus.stage_finished
	bruteforce_used = val

func set_phishing_used(val):
	await SignalBus.stage_finished
	phishing_used = val

func set_antivirus_installed(val):
	await SignalBus.stage_finished
	antivirus_installed = val

func set_antivirus_updated(val):
	await SignalBus.stage_finished
	antivirus_updated = val

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
	
	SignalBus.stage_finished.emit()
	
var _snapshot := {}

func save_snapshot():
	_snapshot = {
		"flashdrive_used": flashdrive_used,
		"email_used": email_used,
		"weak_passwords": weak_passwords,
		"no_password_used": no_password_used,
		"sharing_passwords_used": sharing_passwords_used,
		"noting_passwords": noting_passwords,
		"tailgating_used": tailgating_used,
		"job_application_used": job_application_used,
		"unattended_pc_used": unattended_pc_used,
		"bruteforce_used": bruteforce_used,
		"phishing_used": phishing_used,
		"antivirus_installed": antivirus_installed,
		"antivirus_updated": antivirus_updated,
	}
	print("Snapshot saved: ", _snapshot)

func restore_snapshot():
	if _snapshot.is_empty():
		print("No snapshot to restore!")
		return

	flashdrive_used       = _snapshot["flashdrive_used"]
	email_used            = _snapshot["email_used"]
	weak_passwords        = _snapshot["weak_passwords"]
	no_password_used      = _snapshot["no_password_used"]
	sharing_passwords_used = _snapshot["sharing_passwords_used"]
	noting_passwords      = _snapshot["noting_passwords"]
	tailgating_used       = _snapshot["tailgating_used"]
	job_application_used  = _snapshot["job_application_used"]
	unattended_pc_used    = _snapshot["unattended_pc_used"]
	bruteforce_used       = _snapshot["bruteforce_used"]
	phishing_used         = _snapshot["phishing_used"]
	antivirus_installed   = _snapshot["antivirus_installed"]
	antivirus_updated     = _snapshot["antivirus_updated"]

	print("Snapshot restored")
