extends Node

signal data_loaded

var save_path : String
var file
func check_save_folder():
	var persist_dir := DirAccess.open("user://")
	if persist_dir:
		if not persist_dir.dir_exists("saves"):
			persist_dir.make_dir("saves")
	else:
		printerr("An error occurred trying to open persistent user:// directory. Error: ", DirAccess.get_open_error())

func change_file_name(player_name : String):
	save_path = "user://saves/" + player_name + ".save"
	print(save_path)
	
func save_data():
	check_save_folder()
	var data = {
		"player_name": GameManager.player_name,
		"initial_day": DayAndNightManager.initial_day,
		# Cyberattack flags 
		"flashdrive_used": CyberattackAdaptationManager.flashdrive_used,
		"email_used": CyberattackAdaptationManager.email_used,
		"weak_passwords": CyberattackAdaptationManager.weak_passwords,
		"no_password_used": CyberattackAdaptationManager.no_password_used,
		"sharing_passwords_used": CyberattackAdaptationManager.sharing_passwords_used,
		"noting_passwords": CyberattackAdaptationManager.noting_passwords,
		"tailgating_used": CyberattackAdaptationManager.tailgating_used,
		"job_application_used": CyberattackAdaptationManager.job_application_used,
		"unattended_pc_used": CyberattackAdaptationManager.unattended_pc_used,
		"bruteforce_used": CyberattackAdaptationManager.bruteforce_used,
		"phishing_used": CyberattackAdaptationManager.phishing_used,
		"fileless_used": CyberattackAdaptationManager.fileless_used,
		"antivirus_installed": CyberattackAdaptationManager.antivirus_installed,
		"antivirus_updated": CyberattackAdaptationManager.antivirus_updated,
		"piracy_exploited": CyberattackAdaptationManager.piracy_exploited,
		"lied_to_al": CyberattackAdaptationManager.lied_to_al,
		"lied_to_mike": CyberattackAdaptationManager.lied_to_mike,
		"lied_to_liz": CyberattackAdaptationManager.lied_to_liz
	}
	print("DEBUG: saving data -> ", data) # <--- Debug output
	file = FileAccess.open(save_path, FileAccess.WRITE)
	file.store_var(data)


func load_data():
	if FileAccess.file_exists(save_path):
		file = FileAccess.open(save_path, FileAccess.READ)
		var data = file.get_var()

		# Restore (with default fallbacks)
		GameManager.player_name = data.get("player_name")
		DayAndNightManager.initial_day = data.get("initial_day")
		print (DayAndNightManager.initial_day)
		CyberattackAdaptationManager.flashdrive_used = data.get("flashdrive_used" )
		CyberattackAdaptationManager.email_used = data.get("email_used" )
		CyberattackAdaptationManager.weak_passwords = data.get("weak_passwords" )
		CyberattackAdaptationManager.no_password_used = data.get("no_password_used" )
		CyberattackAdaptationManager.sharing_passwords_used = data.get("sharing_passwords_used")
		CyberattackAdaptationManager.noting_passwords = data.get("noting_passwords")
		CyberattackAdaptationManager.tailgating_used = data.get("tailgating_used")
		CyberattackAdaptationManager.job_application_used = data.get("job_application_used")
		CyberattackAdaptationManager.unattended_pc_used = data.get("unattended_pc_used")
		CyberattackAdaptationManager.bruteforce_used = data.get("bruteforce_used")
		CyberattackAdaptationManager.phishing_used = data.get("phishing_used")
		CyberattackAdaptationManager.fileless_used = data.get("fileless_used")
		CyberattackAdaptationManager.antivirus_installed = data.get("antivirus_installed")
		CyberattackAdaptationManager.antivirus_updated = data.get("antivirus_updated")
		CyberattackAdaptationManager.piracy_exploited = data.get("piracy_exploited")
		CyberattackAdaptationManager.lied_to_al = data.get("lied_to_al")
		CyberattackAdaptationManager.lied_to_mike = data.get("lied_to_mike")
		CyberattackAdaptationManager.lied_to_liz = data.get("lied_to_liz")
		SignalBus.stage_finished.emit()
	else:
		print("No save file found.")
