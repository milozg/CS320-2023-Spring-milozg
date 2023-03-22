####################################################
#!/usr/bin/env python3
####################################################
import sys
sys.path.append('./../../../../mypylib')
from mypylib_cls import *
####################################################
#
# HX-2023-03-14: 20 points
# Please *translate* into Python the posted solution
# on Piazza for word_neighbors (which is writtend in SML)
#
####################################################
def fnlist_tabulate(n,f):
    return fnlist_reverse\
            (int1_foldleft(n,fnlist_nil(),lambda xs,i: fnlist_cons(f(i),xs)))
####################################################
def strsub(word, i):
    return word[i]
def string_length(word):
    return string_foldleft(word, 0, lambda r,_: r + 1)
    
def string_implode(ss):
    return foreach_to_foldleft(fnlist_foreach)(ss, "", lambda r,s: r + s)
def string_tabulate(n,f):
    return string_implode(fnlist_tabulate(n,f))
####################################################
def word_neighbors(word):
    """
    Note that this function should returns a fnlist
    (not a pylist)
    Your implementation should be combinator-based very
    much like the posted solution.
    """
    wlen = string_length(word)
    AB = "abcdefghijklmnopqrstuvwxyz"

    return \
        fnlist_concat(string_imap_fnlist\
                      (word, lambda i, c: fnlist_concat\
                       (string_imap_fnlist(AB, lambda _, c1: fnlist_sing\
                                           (string_tabulate(wlen, lambda j: strsub(word, j) if i != j else c1)) if (c != c1) else fnlist_nil()))))

#
####################################################
