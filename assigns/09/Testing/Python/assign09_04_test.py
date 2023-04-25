######################################################
import sys
######################################################
sys.path.append('../../../07')
######################################################
sys.path.append('./../../MySolution/Python')
from assign09_04 import *
######################################################
myhint0 = \
    [(1, 'a'), (1, 'p'), (0, 'q'), (0, 'x'), (0, 'y')]
myhint1 = \
    [(0, 'b'), (0, 'y'), (1, 'p'), (1, 'l'), (1, 'e')]
myhints = [myhint0, myhint1]
assert "apple" == wordle_guess(myhints)
######################################################
myhint0 = \
    [(0, 'l'), (2, 'i'), (0, 's'), (0, 't'), (2, 'e'), (2, 'n')]
myhint1 = \
    [(0, 's'), (2, 'i'), (0, 'l'), (1, 'e'), (1, 'n'), (0, 't')]
myhint2 = \
    [(0, 'b'), (1, 'r'), (2, 'e'), (0, 'a'), (0, 'c'), (0, 'h')]
myhint3 = \
    [(0, 'p'), (0, 'l'), (2, 'e'), (2, 'n'), (0, 't'), (0, 'y')]
myhint4 = \
    [(0, 'm'), (0, 'o'), (0, 'u'), (0, 't'), (0, 'h'), (0, 'y')]
myhint5 = \
    [(1, 'f'), (0, 'l'), (0, 'a'), (0, 's'), (0, 'h'), (0, 'y')]
myhint6 = \
    [(1, 'f'), (1, 'r'), (1, 'i'), (1, 'e'), (1, 'n'), (1, 'd')]
myhints = \
    [myhint0, myhint1, myhint2, myhint3, myhint4, myhint5, myhint6]
assert "friend" == wordle_guess(myhints)
######################################################
print("Assign09-04-test passed!")
######################################################

#### end of [CS320-2023-Spring-assign09_04_test.py] ####
