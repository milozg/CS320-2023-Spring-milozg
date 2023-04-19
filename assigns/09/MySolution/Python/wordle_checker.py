########################
# HX-2023-04-15: 10 points
########################
import sys
sys.path.append('./../../../../mypylib')
from mypylib_cls import *

"""
Given two words w1 and w2 of the same length,
please implement a function wordle_hint(w1, w2)
that return a sequence of pairs (i, c) for each
character c in w2 where i indicates the color
of c according to the rule of the wordle game:
0: c does not appear in w1
1: c appears in w1 at the same position as it does in w2
2: c appears in w1 at a different position as it does in w2
Please note that the number of times (1, c) or (2, c) appearing
in the returned sequence must be less than or equal to the number
of times c appearing in w1.
For instance,
w1 = water and w2 = water
wordle_hint(w1, w2) =
(1, w), (1, a), (1, t), (1, e), (1, r)
For instance,
w1 = water and w2 = waste
wordle_hint(w1, w2) =
(1, w), (1, a), (0, s), (2, t), (2, e)
For instance,
w1 = abbcc and w2 = bbccd
wordle_hint(w1, w2) =
(2, b), (1, b), (2, c), (1, c), (0, d)
"""
########################################################################
def wordle_hint(w1, w2):
    marks = [~1] * len(w1)
    word_cs = list(w1)
    guess_cs = list(w2)

    for i,c in enumerate(w2):
        if c == w1[i]:
            marks[i] = 1
            guess_cs[i] = 0
            word_cs.remove(c)

    for i,c0 in enumerate(guess_cs):
        if c0 != 0:
            if c0 in word_cs:
                marks[i] = 2
                guess_cs[i] = 0
                word_cs.remove(c0)
            else:
                marks[i] = 0

    return string_imap_pylist(w2, lambda i,c: (marks[i],c))



########################################################################
