import string
import random

setting_data = open('tmpfile1.txt', 'r')
lines = setting_data.readlines()
limited_n_ints = ''
for i in lines:
  limited_n_ints = limited_n_ints + i


## characters to generate password from
characters = list(string.ascii_letters + string.digits + "!@#$%^&*()!@#$%^&*()!@#$%^&*()")

def generate_random_password():
	## length of password from the user
	length = int(limited_n_ints)

	## shuffling the characters
	random.shuffle(characters)
	
	## picking random characters from the list
	password = []
	for i in range(length):
		password.append(random.choice(characters))

	## shuffling the resultant password
	random.shuffle(password)

	## converting the list to string
	## printing the list
	print("".join(password))



generate_random_password()

