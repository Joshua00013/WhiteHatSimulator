extends MarginContainer

@export var back_button : Button
@export var overlay : ColorRect
@export var code_edit : CodeEdit
@export var description : RichTextLabel
@export var animation : AnimationPlayer

var step : int = 0

var bruteforce_code = {
	"step_1" : "import random\n\n",
	"step_2" : "character = \"0123456789abcdefghijklmnopqrstuvwzyzñABCDEFGHIJKLMNOPQ\nRSTUVWXYZÑ \"\ncharacter_list = list(character)\n\n",
	"step_3" : "password = \"Cypher2025 \")\n",
	"step_4" : "guess = \"\"\n\n",
	"step_5" : "while (guess != password):\n\tguess = random.choices(character_list, k=len(password))\n\tprint(guess)\n\tguess = \"\".join(guess)\n\tprint(guess)\n",
	"step_6" : "print(\"The password is \" + guess)"
}

func _ready() -> void:
	code_edit.text=""
	description.text = "Brute Force\n\nA brute force attack is a way hackers try to break into a system by guessing the password or key through every possible combination. Instead of using smart tricks, they rely on the computer’s speed to test thousands or even millions of possibilities until the right one works. Think of it like trying to open a lock by testing every single key until one finally fits. While this method always works eventually, it can take a very long time if the password is strong and complex."

func _on_next_pressed() -> void:
	back_button.disabled = false
	step += 1
	set_step(step)
		

func _on_back_pressed() -> void:
	if step > 0:
		step -= 1
		set_step(step)
		back_button.disabled = false
	if step == 0:
		set_step(step)
		back_button.disabled = true
	
func set_step(step: int):
	match step:
		1: 
			code_edit.text = bruteforce_code.step_1
			description.text = "Step 1 – Import the random module:\n\nWe start by importing Python’s random module. This gives us tools to generate random values. Without this, we couldn’t make random guesses."
			animation.play("Bruteforce_step_1")
		2:
			description.text = "Step 1 – Import the random module:\n\nIt’s like telling Python, ‘Hey, I want to use tools that can generate random numbers or random choices.’ Without this line, the program won’t know how to pick random letters."
		3: 
			code_edit.text = bruteforce_code.step_1 + bruteforce_code.step_2
			description.text = "Step 2 – Define possible characters:\n\nThe character variable contains all the characters we allow in our password attempts such as:\n\nNumbers (0–9), small letters (a–z, ñ), capital letters (A–Z, Ñ), and even a space."
			animation.play("Bruteforce_step_2")
		4:
			description.text = "Step 2 – Define possible characters:\n\nThe character_list variable turn the string into a list of single characters, for example: ['0', '1', 'b', 'Ñ', ' ']. \n\nThis makes it easier for Python to randomly pick letters one by one and try all possible character combinations until it matches the password we entered."
			animation.play("Bruteforce_step_3")
		5: 
			code_edit.text = bruteforce_code.step_1 + bruteforce_code.step_2 + bruteforce_code.step_3
			description.text = "Step 3 – Setting up the password:\n\nThe user password here is specified as 'Cyper2025', and the computer will try to guess it..\n\nThe computer will combine all possible character combinations stored in character variable."
			animation.play("Bruteforce_step_4")
		6:
			code_edit.text = bruteforce_code.step_1 + bruteforce_code.step_2 + bruteforce_code.step_3  + bruteforce_code.step_4
			description.text = "Step 4: Initializing guess variable as the attempt container:\n\nBefore guessing begins, we set variable guess to an empty string. This will later store the computer’s password guesses."
			animation.play("Bruteforce_step_5")
		7:
			code_edit.text = bruteforce_code.step_1 + bruteforce_code.step_2 + bruteforce_code.step_3  + bruteforce_code.step_4 + bruteforce_code.step_5
			description.text = "Step 5: The guessing loop:\n\nThis loop will Keep guessing again and again until the guess is exactly the same as the password.The loop won’t stop until the guess variable matches the password."
			animation.play("Bruteforce_step_6")
		8:
			description.text = "Step 6 – Make a random guess:\n\nIt picks a random characters from the list."
			animation.play("Bruteforce_step_7")
		9:
			description.text = "Step 6 – Make a random guess:\n\nIt makes sure the guess has the same number of letters as the password."
			animation.play("Bruteforce_step_8")
		10:
			description.text = "Step 6 – Make a random guess:\n\nIt shows the list form so we can see the raw characters, like ['7','a']."
			animation.play("Bruteforce_step_9")
		11:
			description.text = "Step 7 – Join characters into a word:\n\nIt convert the list together into a single string, like this Example: ['7','a'] → \"7a\"."
			animation.play("Bruteforce_step_10")
		12:
			code_edit.text = bruteforce_code.step_1 + bruteforce_code.step_2 + bruteforce_code.step_3  + bruteforce_code.step_4 + bruteforce_code.step_5 + bruteforce_code.step_6
			description.text = "Step 8 – Print the result:\n\nWhen the loop ends, it means the computer has finally found the correct password combination. Then it will print the matched password."
			animation.play("Bruteforce_step_11")
		13:
			description.text = "Now lets run the code"
		14: 
			pass
			
			
