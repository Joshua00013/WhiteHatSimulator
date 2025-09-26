extends Node

var popup : PopupWindow
var task_box : TaskBox
var quiz_ui : Control
var game_over_ui : Control
var tutorial_ui : Control

var nav_button_active := false

var next_button : Button
var back_button : Button

signal show_nav_buttons
signal hide_nav_buttons

signal laptop_play_ransomware
signal laptop_play_phishing
signal laptop_play_fileless
