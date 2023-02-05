####################################################
import sys
sys.path.append('..')
from assign02 import *
from assign02_01 import *
####################################################
print("[import ./../assign02.py] is done!")
####################################################
#
# Please implement (10 points)
# mylist_quicksort (see list_quicksort in assign02.sml)

def mylist_qpart(xs,n):
    if mylist_nilq(xs):
        return (mylist_nil(),mylist_nil())
    else:
        (ys,zs) = mylist_qpart(mylist_cons.get_cons2(xs),n)
        x1 = mylist_cons.get_cons1(xs)
        if x1 <= n:
            return (mylist_cons(x1,ys),zs)
        else:
            return (ys,mylist_cons(x1,zs))

def mylist_quicksort(xs):
    if mylist_nilq(xs):
        return mylist_nil()
    else:
        x1 = mylist_cons.get_cons1(xs)
        (ys,zs) = mylist_qpart(mylist_cons.get_cons2(xs),x1)
        ys = mylist_quicksort(ys)
        zs = mylist_quicksort(zs)
        return mylist_append(ys,mylist_cons(x1,zs))

#
####################################################
