extends Node

var ui_active : bool = false #Variable for checking if theres an active ui. Defaulted to false as the player doesnt spawn with UI on
var game_paused : bool = false # Variable for pausing the game
var is_crouching :bool = false

var player_camera : Camera3D
var player : CharacterBody3D
