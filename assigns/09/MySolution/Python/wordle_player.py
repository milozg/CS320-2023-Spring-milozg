########################
# HX-2023-04-15: 20 points
########################
import sys
sys.path.append('./../../../../mypylib')
from mypylib_cls import *

"""
Given a history of wordle hints, this function returns a
word as the player's guess.
"""
########################################################################
def wordle_guess(hints):
    guess = ['$'] * len(hints[0])
    bank = "abcdefghijklmnopqrstuvwxyz"
    bank = string_pylistize(bank)
    twos = set()

    for hint in hints:
        for i,c in enumerate(hint):
            if c[0] == 1:
                guess[i] = c[1]
            elif c[0] == 2:
                twos.add((i,c[1]))
            else:
                if c[1] in bank:
                    bank.remove(c[1])

    for i,c in enumerate(guess):
        if c == '$':
            temp_bank = pylist_make_filter(bank, lambda x: not (i,x) in twos)
            guess[i] = temp_bank[0]

    return pylist_foldleft(guess,'', lambda r,c: r + c)
########################################################################
