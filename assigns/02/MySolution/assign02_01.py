####################################################
import sys
sys.path.append('..')
from assign02 import *
####################################################
print("[import ./../assign02.py] is done!")
####################################################
#
# Please implement (20 points)
# mylist_append (see list_append in assign02.sml)

def mylist_append(xs,ys):
    if mylist_nilq(xs):
        return ys
    else:
        return mylist_cons(mylist_cons.get_cons1(xs),mylist_append(mylist_cons.get_cons2(xs),ys))

# mylist_rappend (see list_rappend in assign02.sml)

def mylist_rappend(xs,ys):
    if mylist_nilq(xs):
        return ys
    else:
        return mylist_rappend(mylist_cons.get_cons2(xs),mylist_cons(mylist_cons.get_cons1(xs),ys))

# mylist_reverse (see list_reverse in assign02.sml)

def mylist_reverse(xs):
    return mylist_rappend(xs,mylist_nil())

#
####################################################
