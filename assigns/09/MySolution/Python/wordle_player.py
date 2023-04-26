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
            return foreach_to_iforall(string_foreach)(s, lambda i,c: (not (i,c) in twos) and (c != '$'))
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


print(wordle_guess([[(2,'l'),(0,'a'),(1,'a'),(2,'e'),(2,'l')]]))
########################################################################
