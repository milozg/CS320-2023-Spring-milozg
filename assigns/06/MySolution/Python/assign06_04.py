####################################################
#!/usr/bin/env python3
####################################################
import sys
import queue
sys.path.append('../../../06')
sys.path.append('./../../../../mypylib')
from dictwords import *
from mypylib_cls import *
####################################################
"""
HX-2023-03-24: 30 points
Solving the doublet puzzle
"""
####################################################
# CODE FROM 05-02
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
####################################################

def children(curr_words, q):
    neighbors = word_neighbors(curr_words[-1])
    def helper(wd):
        if word_is_legal(wd):
            q.put(curr_words + (wd,))
    fnlist_foreach(neighbors, lambda w: helper(w))
    return None

def doublet_bfs(wordq, fchildren):
    def helper(words):
        if words.empty():
            return strcon_nil()
        else:
            curr = words.get()
            fchildren(curr,words)
            return strcon_cons(curr, lambda: helper(words))
    return lambda: helper(wordq)

def doublet_stream_from(word):
    """
    Please revisit assign05_02.py.
    ######
    Given a word w1 and another word w2, w1 and w2 are a
    1-step doublet if w1 and w2 differ at exactly one position.
    For instance, 'water' and 'later' are a 1-step doublet.
    The doublet relation is the reflexive and transitive closure
    of the 1-step doublet relation. In other words, w1 and w2 are
    a doublet if w1 and w2 are the first and last of a sequence of
    words where every two consecutive words form a 1-step doublet.
    Here is a little website where you can use to check if two words
    for a doublet or not:
    http://ats-lang.github.io/EXAMPLE/BUCS320/Doublets/Doublets.html
    ######
    Given a word, the function [doublet_stream_from] returns a stream
    enumerating *all* the tuples such that the first element of the tuple
    is the given word and every two consecutive words in the tuple form a
    1-step doublet. The enumeration of tuples should be done so that shorter
    tuples are always enumerated ahead of longer ones.
    ######
    """
    initq = queue.Queue()
    initq.put((word,))
    return doublet_bfs(initq,children)

# stream_iforall(doublet_stream_from("water"), lambda i,x: i < 100 and not print(x))
####################################################
