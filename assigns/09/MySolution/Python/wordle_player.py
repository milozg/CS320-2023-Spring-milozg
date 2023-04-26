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

def most_occuring_key(d):
    for k in d:
        d[k] = len(d[k])
    return max(d,key = d.get)

########################################################################
# def wordle_guess(hints):
#     guess = ['$'] * len(hints[0])
#     bank = "abcdefghijklmnopqrstuvwxyz"
#     bank = string_pylistize(bank)
#     twos = []
#
#     for hint in hints:
#         for i,c in enumerate(hint):
#             if c[0] == 1:
#                 guess[i] = c[1]
#             elif c[0] == 2:
#                 twos += [(i,c[1])]
#             else:
#                 if c[1] in bank:
#                     bank.remove(c[1])
#
#     twos.reverse()
#
#     for i,c in enumerate(guess):
#         if c == '$':
#             twos_updated = pylist_make_filter(twos, lambda x: x[0] != i)
#             print(twos_updated)
#             guess[i] = twos_updated[0][1]
#             twos.remove(twos_updated[0])
#
#     for i,c in enumerate(guess):
#         if c == '$':
#             guess[i] = bank[0]
#
#     return pylist_foldleft(guess,'', lambda r,c: r + c)

def wordle_guess(hints):
    guess = ['$'] * len(hints[0])
    bank = "abcdefghijklmnopqrstuvwxyz"
    bank = string_pylistize(bank)
    twos = dict()

    for hint in hints:
        for i,c in enumerate(hint):
            if c[0] == 1:
                guess[i] = c[1]
            elif c[0] == 2:
                if c[1] in twos:
                    twos[c[1]] += [i]
                else:
                    twos[c[1]] = [i]
            else:
                if c[1] in bank:
                    bank.remove(c[1])

    print(twos)

    for i,c in enumerate(guess):
        if c == '$':
            twos_updated = twos.copy()
            two_be_removed = []
            for k in twos_updated:
                if i in twos_updated[k]:
                    two_be_removed += k

            for k in two_be_removed:
                del twos_updated[k]
            print(twos_updated)
            if len(twos_updated) > 0:
                c = most_occuring_key(twos_updated)
                if len(twos[c]) > 1:
                    twos[c].pop(0)
                else:
                    del twos[c]
                guess[i] = c
            else:
                guess[i] = bank[0]

    return pylist_foldleft(guess,'', lambda r,c: r + c)

# print(wordle_guess([[(2,'l'),(2,'a'),(2,'t'),(2,'e'),(2,'r')]]))
########################################################################
