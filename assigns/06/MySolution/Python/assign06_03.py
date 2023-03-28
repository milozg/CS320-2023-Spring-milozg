####################################################
#!/usr/bin/env python3
####################################################
import sys
sys.path.append('./../../../../mypylib')
from mypylib_cls import *
####################################################
"""
HX-2023-03-24: 20 points
Solving the N-queen puzzle
"""
####################################################
# FROM THE TEST CODE
# ↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓
######################################################
def nqueen(bd):
    res = 0
    for j0 in bd:
        if j0 <= 0:
            break
        else:
            res = res + 1
    return res
def board_safety_all(bd):
    return \
        int1_forall\
        (nqueen(bd), \
         lambda i0: board_safety_one(bd, i0))
def board_safety_one(bd, i0):
    def helper(j0):
        pi = bd[i0]
        pj = bd[j0]
        return pi != pj and abs(i0-j0) != abs(pi-pj)
    return int1_forall(i0, helper)
####################################################

def set_board(bd,i0,j0):
    lst = list(bd)
    lst[i0] = j0
    return tuple(lst)

def check_board_set(bd,i0,j0):
    return board_safety_one(set_board(bd,i0,j0),i0)

def get_safe_childs(bd,bdSize):
    def helper(r,n):
        if check_board_set(bd,nqueen(bd),n):
            return fnlist_cons(set_board(bd,nqueen(bd),n),r)
        else:
            return r

    return int1_foldleft(bdSize, fnlist_nil(), lambda r,n: helper(r,n))

def gtree_dfs(bds,bdSize):
    if fnlist.get_ctag(bds) == 0:
        return strcon_nil()
    else:
        c1 = fnlist_cons.get_cons1(bds)
        c2 = fnlist_cons.get_cons2(bds)
        if board_safety_all(c1) and nqueen(c1) == bdSize:
            return\
            strcon_cons(c1,gtree_dfs(fnlist_append(c2,get_safe_childs(c1,bdSize)),bdSize))
        else:
            return\
            gtree_dfs(fnlist_append(c2,get_safe_childs(c1,bdSize)),bdSize)

def solve_N_queen_puzzle(N):
    """
    Please revisit assign04-04.sml.
    A board of size N is a tuple of length N.
    ######
    For instance, a tuple (0, 0, 0, 0) stands
    for a board of size 4 (that is, a 4x4 board)
    where there are no queen pieces on the board.
    ######
    For instance, a tuple (2, 1, 0, 0) stands
    for a board of size 4 (that is, a 4x4 board)
    where there are two queen pieces; the queen piece
    on the 1st row is on the 2nd column; the queen piece
    on the 2nd row is on the 1st column; the last two rows
    contain no queen pieces.
    ######
    This function [solve_N_queen_puzzle] should return
    a stream of ALL the boards of size N that contain N
    queen pieces (one on each row and on each column) such
    that no queen piece on the board can catch any other ones
    on the same board.
    """
    init_board = (-1,) * N
    return lambda:gtree_dfs(fnlist_sing(init_board),N)

####################################################
