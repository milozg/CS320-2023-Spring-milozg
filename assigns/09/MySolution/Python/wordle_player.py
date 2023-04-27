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

#######################################################################
def replace_str(str, i, replacement):
    return str[:i] + replacement + str[i + 1:]

def wordle_guess(hints):
    guess = "$" * len(hints[0])
    bank = list("abcdefghijklmnopqrstuvwxyz")
    twos = set()
    counts = dict()

    for hint in hints:
        word = pylist_make_map(pylist_make_filter(hint, lambda x: x[0] != 0), lambda x: x[1])
        count_in_word = {x:word.count(x) for x in word}

        for k in count_in_word:
            if k not in counts or count_in_word[k] > counts[k]:
                counts[k] = count_in_word[k]

        for i,c in enumerate(hint):
            if c[0] == 1:
                guess = replace_str(guess,i,c[1])
            elif c[0] == 2:
                    twos.add((i,c[1]))

    for i,c in enumerate(hint):
        if c[0] == 0:
            if c[1] not in counts:
                bank.remove(c[1])

    def word_is_safe(wd):
        def pos_safe(s):
            return foreach_to_iforall(string_foreach)(s, lambda i,c: (not (i,c) in twos))

        def count_safe(d, s):
            wd_list = list(s)
            count_in_word = {x:wd_list.count(x) for x in wd_list}
            res = True
            for k in d:
                if not ((k in count_in_word) and count_in_word[k] == d[k]):
                    res =  False
            return res

        return pos_safe(wd) and count_safe(counts,wd) and (not '$' in wd)

    def nexts(nx1):
        childs = []
        try:
            i = nx1.index('$')
            return string_imap_pylist(bank, lambda _,c: replace_str(nx1,i,c))
        except ValueError:
            return []

    if '$' in guess:
        graph = stream_make_filter(graph_dfs([guess], nexts), lambda s: word_is_safe(s))
        return stream_get_at(graph,0)
    else:
        return guess



# print(wordle_guess([[(2,'l'),(0,'a'),(2,'t'),(2,'e'),(1,'l')]]))

# myhint0 = \
#     [(0, 'l'), (2, 'i'), (0, 's'), (0, 't'), (2, 'e'), (2, 'n')]
# myhint1 = \
#     [(0, 's'), (2, 'i'), (0, 'l'), (1, 'e'), (1, 'n'), (0, 't')]
# myhint2 = \
#     [(0, 'b'), (2, 'r'), (2, 'e'), (0, 'a'), (0, 'c'), (0, 'h')]
# myhint3 = \
#     [(0, 'p'), (0, 'l'), (2, 'e'), (2, 'n'), (0, 't'), (0, 'y')]
# myhint4 = \
#     [(0, 'm'), (0, 'o'), (0, 'u'), (0, 't'), (0, 'h'), (0, 'y')]
# myhint5 = \
#     [(2, 'f'), (0, 'l'), (2, 'd'), (0, 's'), (0, 'h'), (0, 'y')]
# myhints = \
#     [myhint0, myhint1, myhint2, myhint3, myhint4, myhint5]
#
# print(wordle_guess(myhints))
########################################################################
