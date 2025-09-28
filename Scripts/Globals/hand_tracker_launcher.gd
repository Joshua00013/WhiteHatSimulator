extends Node

func launch_hand_tracker():
	# Correct usage:
	# OS.execute(path, arguments_array, blocking = false, output = null)
	var exe_path = ProjectSettings.globalize_path("res://HandTracker/app.exe")
	var args = []  # must be an Array, even if empty

	# blocking = false (optional)
	var pid = OS.create_process(exe_path, args)
	print(pid)

func check_hand_tracker():
	var exe_path = ProjectSettings.globalize_path("res://HandTracker/app.exe")
	return FileAccess.file_exists(exe_path)
