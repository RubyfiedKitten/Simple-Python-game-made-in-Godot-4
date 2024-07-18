extends Node2D

var GUESSLIMIT = 13
var upperlimit = 10000
var rannum = randi_range(1, upperlimit)
var guesses = 1
var highest:= 10000
var lowest:= 1

func _ready():
	$ui/guess_limit.text = "Guesses left: " + str(GUESSLIMIT + 1)
	$ui/high_low.text = ""
	$ui/highest.text = "Highest: " + str(highest)
	$ui/lowest.text = "Lowest: " + str(lowest)
	$ui/rannum.text = "Hidden Number"

func _on_button_pressed():
	if guesses <= GUESSLIMIT:
		$button.play()
		var guessnum = $ui/Player_input.text
		
		if guessnum.to_int() > rannum:
			$ui/high_low.text = "Too high"
			highest = guessnum.to_int()
			guesses += 1
			$ui/guess_limit.text = "Guesses left: " + str(GUESSLIMIT - guesses + 2)
			$ui/Player_input.text = ""
			$ui/highest.text = "Highest: " + str(highest)
		elif guessnum.to_int() < rannum:
			$ui/high_low.text = "Too low"
			lowest = guessnum.to_int()
			guesses += 1
			$ui/guess_limit.text = "Guesses left: " + str(GUESSLIMIT - guesses + 2)
			$ui/Player_input.text = ""
			$ui/lowest.text = "Lowest: " + str(lowest)
		else:
			victory()
	elif guesses >= GUESSLIMIT:
		fail()

func victory():
	$ui/high_low.horizontal_alignment = 0
	$ui/high_low.add_theme_font_size_override("font_size", 20)
	$ui/high_low.text = "Congratulations :)"
	$ui/rannum.text = str(rannum)
	$Timer.start()
	$correct.play()

func fail():
	$ui/high_low.horizontal_alignment = 0
	$ui/high_low.add_theme_font_size_override("font_size", 20)
	$ui/high_low.text = "Too bad :("
	$ui/rannum.text = str(rannum)
	$wrong.play()
	$Timer.start()

func _on_timer_timeout():
	get_tree().reload_current_scene()
