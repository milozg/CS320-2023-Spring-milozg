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


# def most_occuring_key(d):
#     for k in d:
#         d[k] = len(d[k])
#     return max(d,key = d.get)
#
# def wordle_guess(hints):
#     guess = ['$'] * len(hints[0])
#     bank = "abcdefghijklmnopqrstuvwxyz"
#     bank = string_pylistize(bank)
#     twos = dict()
#
#     for hint in hints:
#         for i,c in enumerate(hint):
#             if c[0] == 1:
#                 guess[i] = c[1]
#             elif c[0] == 2:
#                 if c[1] in twos:
#                     twos[c[1]] += [i]
#                 else:
#                     twos[c[1]] = [i]
#             else:
#                 if c[1] in bank:
#                     bank.remove(c[1])
#
#     print(twos)
#
#     for i,c in enumerate(guess):
#         if c == '$':
#             twos_updated = twos.copy()
#             two_be_removed = []
#             for k in twos_updated:
#                 if i in twos_updated[k]:
#                     two_be_removed += k
#
#             for k in two_be_removed:
#                 del twos_updated[k]
#             print(twos_updated)
#             if len(twos_updated) > 0:
#                 c = most_occuring_key(twos_updated)
#                 if len(twos[c]) > 1:
#                     twos[c].pop(0)
#                 else:
#                     del twos[c]
#                 guess[i] = c
#             else:
#                 guess[i] = bank[0]
#
#     return pylist_foldleft(guess,'', lambda r,c: r + c)
def graph_dfs(nxs, fnexts):
    visited = set()
    def helper(qnxs):
        if qnxs.empty():
            return strcon_nil()
        else:
            nx1 = qnxs.get()
            # print("gtree_dfs: helper: nx1 = ", nx1)
            for nx2 in reversed(fnexts(nx1)):
                if not nx2 in visited:
                    qnxs.put(nx2)
                    visited.add(nx2)
            return strcon_cons(nx1, lambda: helper(qnxs))
        # end-of-(if(qnxs.empty())-then-else)
    qnxs = queue.LifoQueue()
    for nx0 in nxs:
        qnxs.put(nx0)
        visited.add(nx0)
    return lambda: helper(qnxs)

def replace_str(str, i, replacement):
    return str[:i] + replacement + str[i + 1:]

def wordle_guess(hints):
    guess = "$" * len(hints[0])
    bank = list("abcdefghijklmnopqrstuvwxyz")
    twos = set()
    twos_cnt = []

    for hint in hints:
        for i,c in enumerate(hint):
            if c[0] == 1:
                guess = replace_str(guess,i,c[1])
            elif c[0] == 2:
                twos.add((i,c[1]))
                twos_cnt += c[1]
            else:
                if c[1] in bank:
                    bank.remove(c[1])

    def word_is_safe(wd):
        wd_list = list(wd)
        def pos_safe(s):
            return foreach_to_iforall(string_foreach)(s, lambda i,c: (not (i,c) in twos) and (c in bank))
        def count_safe(l):
            res = True
            for c in twos_cnt:
                if c in l:
                    l.remove(c)
                else:
                    res = False
                    break
            return res
        return pos_safe(wd) and count_safe(wd_list)

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


print(wordle_guess([[(2,'l'),(2,'a'),(2,'a'),(2,'e'),(2,'l')]]))
########################################################################
