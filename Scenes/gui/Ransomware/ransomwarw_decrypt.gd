extends Control


@onready var label_01: Label = $Label01
@onready var next_bt_01: Button = $next_bt01

func _on_next_bt_01_pressed() -> void:
	label_01.visible =false
	next_bt_01.visible = false
	
	overlay_1.visible = true
	label_1.visible =true
	next_btn_1.visible = true
	back_btn_1.visible = true
	
@onready var overlay_1: ColorRect = $Overlay1	
@onready var label_1: Label = $Label1
@onready var next_btn_1: Button = $next_btn1
@onready var back_btn_1: Button = $back_btn1

func _on_next_btn_1_pressed() -> void:
	overlay_1.visible = false
	label_1.visible =false
	next_btn_1.visible = false
	back_btn_1.visible = false
	
	overlay_2.visible = true
	label_2.visible =true
	next_btn_2.visible = true
	back_btn_2.visible = true


func _on_back_btn_1_pressed() -> void:
	overlay_1.visible = false
	label_1.visible =false
	next_btn_1.visible = false
	back_btn_1.visible = false
	
	label_01.visible =true
	next_bt_01.visible = true
	
@onready var overlay_2: ColorRect = $Overlay2	
@onready var label_2: Label = $Label2
@onready var next_btn_2: Button = $next_btn2
@onready var back_btn_2: Button = $back_btn2

func _on_next_btn_2_pressed() -> void:
	overlay_2.visible = false
	label_2.visible =false
	next_btn_2.visible = false
	back_btn_2.visible = false
	
	overlay_3.visible = true
	label_3.visible =true
	next_btn_3.visible = true
	back_btn_3.visible = true


func _on_back_btn_2_pressed() -> void:
	overlay_2.visible = false
	label_2.visible =false
	next_btn_2.visible = false
	back_btn_2.visible = false
	
	overlay_1.visible = true
	label_1.visible =true
	next_btn_1.visible = true
	back_btn_1.visible = true
	
@onready var overlay_3: ColorRect = $Overlay3
@onready var label_3: Label = $Label3
@onready var next_btn_3: Button = $next_btn3
@onready var back_btn_3: Button = $back_btn3


func _on_next_btn_3_pressed() -> void:
	overlay_3.visible = false
	label_3.visible =false
	next_btn_3.visible = false
	back_btn_3.visible = false
	
	overlay_4.visible = true
	label_4.visible =true
	next_btn_4.visible = true
	back_btn_4.visible = true


func _on_back_btn_3_pressed() -> void:
	overlay_3.visible = false
	label_3.visible =false
	next_btn_3.visible = false
	back_btn_3.visible = false
	
	overlay_2.visible = true
	label_2.visible =true
	next_btn_2.visible = true
	back_btn_2.visible = true
	
@onready var overlay_4: ColorRect = $Overlay4
@onready var label_4: Label = $Label4
@onready var next_btn_4: Button = $next_btn4
@onready var back_btn_4: Button = $back_btn4


func _on_next_btn_4_pressed() -> void:
	overlay_4.visible = false
	label_4.visible =false
	next_btn_4.visible = false
	back_btn_4.visible = false
	
	overlay_5.visible = true
	label_5.visible =true
	next_btn_5.visible = true
	back_btn_5.visible = true

func _on_back_btn_4_pressed() -> void:
	overlay_4.visible = false
	label_4.visible =false
	next_btn_4.visible = false
	back_btn_4.visible = false
	
	overlay_3.visible = true
	label_3.visible =true
	next_btn_3.visible = true
	back_btn_3.visible = true
	
@onready var overlay_5: ColorRect = $Overlay5	
@onready var label_5: Label = $Label5
@onready var next_btn_5: Button = $next_btn5
@onready var back_btn_5: Button = $back_btn5


func _on_next_btn_5_pressed() -> void:
	overlay_5.visible = false
	label_5.visible =false
	next_btn_5.visible = false
	back_btn_5.visible = false
	
	overlay_6.visible = true
	label_6.visible =true
	next_btn_6.visible = true
	back_btn_6.visible = true


func _on_back_btn_5_pressed() -> void:
	overlay_5.visible = false
	label_5.visible =false
	next_btn_5.visible = false
	back_btn_5.visible = false
	
	overlay_4.visible = true
	label_4.visible =true
	next_btn_4.visible = true
	back_btn_4.visible = true
	
@onready var overlay_6: ColorRect = $Overlay6	
@onready var label_6: Label = $Label6
@onready var next_btn_6: Button = $next_btn6
@onready var back_btn_6: Button = $back_btn6

func _on_next_btn_6_pressed() -> void:
	overlay_6.visible = false
	label_6.visible =false
	next_btn_6.visible = false
	back_btn_6.visible = false
	
	overlay_7.visible = true
	label_7.visible =true
	next_btn_7.visible = true
	back_btn_7.visible = true


func _on_back_btn_6_pressed() -> void:
	overlay_6.visible = false
	label_6.visible =false
	next_btn_6.visible = false
	back_btn_6.visible = false
	
	overlay_5.visible = true
	label_5.visible =true
	next_btn_5.visible = true
	back_btn_5.visible = true
	
@onready var overlay_7: ColorRect = $Overlay7	
@onready var label_7: Label = $Label7
@onready var next_btn_7: Button = $next_btn7
@onready var back_btn_7: Button = $back_btn7


func _on_next_btn_7_pressed() -> void:
	overlay_7.visible = false
	label_7.visible =false
	next_btn_7.visible = false
	back_btn_7.visible = false
	
	


func _on_back_btn_7_pressed() -> void:
	overlay_7.visible = false
	label_7.visible =false
	next_btn_7.visible = false
	back_btn_7.visible = false
	
	overlay_6.visible = true
	label_6.visible =true
	next_btn_6.visible = true
	back_btn_6.visible = true
