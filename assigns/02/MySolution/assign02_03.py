####################################################
import sys
sys.path.append('..')
from assign02 import *
####################################################
print("[import ./../assign02.py] is done!")
####################################################
#
# Please implement (20 points)
# mylist_mergesort (see list_mergesort in assign02.sml)
#

def singleton(x):
    return mylist_cons(x,mylist_nil())

def mylist_split(xs):
    if mylist_nilq(xs):
        return (mylist_nil(),mylist_nil())
    elif mylist_nilq(mylist_cons.get_cons2(xs)):
        return (singleton(mylist_cons.get_cons1(xs)),mylist_nil())
    else:
        x1 = mylist_cons.get_cons1(xs)
        x2 = mylist_cons.get_cons1(mylist_cons.get_cons2(xs))
        xs2 = mylist_cons.get_cons2(mylist_cons.get_cons2(xs))
        (ys,zs) = mylist_split(xs2)
        return (mylist_cons(x1,ys),mylist_cons(x2,zs))

def mylist_merge(ys,zs):
    if mylist_nilq(ys):
        return zs
    elif mylist_nilq(zs):
        return ys
    else:
        y1 = mylist_cons.get_cons1(ys)
        z1 = mylist_cons.get_cons1(zs)
        ys2 = mylist_cons.get_cons2(ys)
        zs2 = mylist_cons.get_cons2(zs)
        if y1 <= z1:
            return mylist_cons(y1, mylist_merge(ys2,zs))
        else:
            return mylist_cons(z1, mylist_merge(ys,zs2))

def mylist_mergesort(xs):
    if mylist_nilq(xs):
        return mylist_nil()
    elif mylist_nilq(mylist_cons.get_cons2(xs)):
        return singleton(mylist_cons.get_cons1(xs))
    else:
        x1 = mylist_cons.get_cons1(xs)
        x2 = mylist_cons.get_cons1(mylist_cons.get_cons2(xs))
        xs2 = mylist_cons.get_cons2(mylist_cons.get_cons2(xs))
        (ys,zs) = mylist_split(xs2)
        return mylist_merge(mylist_mergesort(mylist_cons(x1,ys)), mylist_mergesort(mylist_cons(x2,zs)))

####################################################
