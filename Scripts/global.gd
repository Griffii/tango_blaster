# Global Script
extends Node

# Global variables
var player_health: int = 100
var scene_number: int = 0 # 0-Home, 1-N5, 2-N4 ... 5-N1, 6-Hiragana/Katakana, 7-Mixed

# Held resources variables
var n5_cards = 0
var n4_cards = 0
var n3_cards = 0
var n2_cards = 0
var n1_cards = 0
var n0_cards = 0

var is_game_paused: bool = false
var is_game_over: bool = false

# Character (enemy) variables
var char_wave_number: int =1
var total_char_in_wave: int = 0
var char_spawn_rate: float = 1.0

var move_speed = 70 # Speed if not defined in node itself

# Global array of spawned sprites via type
var sprite_array_type = []
