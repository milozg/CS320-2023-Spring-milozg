import sys
sys.path.append('./')
from wordle_checker import *

sys.path.append('./../../../../mypylib')
from mypylib_cls import *

import random

answers = open("wordle-answers-alphabetical.txt", "r")
data = answers.read()
answer_list = data.split("\n")
answers.close()

words = open("wordle-allowed-guesses.txt", "r")
data = words.read()
words_list = data.split("\n")
words_list += answer_list
words.close()
words_set = set(words_list)

secret = answer_list[random.randrange(2315)]

def valid_word(word):
    return word in words_set
    
def hint_to_ascii(hint):
    res = ''
    for c in hint:
        if c[0] == 1:
            res += '+'
        elif c[0] == 2:
            res += '-'
        else:
            res += 'X'
    return res

i = 0
while i < 6:
    while True:
        print("Enter your guess: ")
        guess = input()
        if valid_word(guess):
            break
        else:
            print("that aint a word dumb dumb")
    hint = wordle_hint(secret,guess)
    right = True
    for c in hint:
        if c[0] != 1:
            right = False
    if right:
        print("YOU WON")
        break
    elif i == 5:
        print("YOU LOSE, THE WORD WAS: " + secret)
        break
    else:
        print(hint_to_ascii(hint))
        i += 1
