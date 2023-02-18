#########################################################################
# (* ****** ****** *)
# (*
# HX-2023-02-17:
# Library functions
# for BUCASCS320-2023-Spring
# This is a class-wide library,
# that is, it is shared by the class.
# *)
# (* ****** ****** *)
#########################################################################

def int1_forall(n0, test_func):
    i0 = 0
    while(i0 < n0):
        if not test_func(i0):
            return False
        i0 = (i0 + 1)
    return True # test_func(i0)==True for all 0 <= i0 < n0

def int1_foreach(n0, work_func):
    i0 = 0
    while(i0 < n0):
        work_func(i0)
        i0 = (i0 + 1)
    return None # work_func(i0) is done for all 0 <= i0 < n0

def int1_rforeach(n0, work_func):
    i0 = 0
    while(i0 < n0):
        work_func(n0-1-i0)
        i0 = (i0 + 1)
    return None # work_func(i0) is done for all n0 > i0 >= 0

def int1_foldleft(xs, r0, fopr_func):
    return foreach_to_foldleft(int1_foreach)(x0, r0, fopr_func)
def int1_foldright(xs, r0, fopr_func):
    return rforeach_to_foldright(int1_rforeach)(x0, r0, fopr_func)

#########################################################################

def list_foreach(xs, work_func):
    for x0 in xs:
        work_func(x0)
    return None # work_func(x0) is done for all x0 in xs

def list_rforeach(xs, work_func):
    for x0 in reversed(xs):
        work_func(x0)
    return None # work_func(i0) is done for all x0 in reversed(xs)

def list_flistize(xs):
    return foreach_to_rflistize(list_rforeach)(xs)

def list_foldleft(xs, r0, fopr_func):
    return foreach_to_foldleft(list_foreach)(x0, r0, fopr_func)
def list_foldright(xs, r0, fopr_func):
    return rforeach_to_foldright(list_rforeach)(x0, r0, fopr_func)

#########################################################################

# datatype 'a list =
# nil | cons of ('a * 'a list)

class flist:
    ctag = -1
    def get_ctag(self):
        return self.ctag
# end-of-class(flist)

class flist_nil(flist):
    def __init__(self):
        self.ctag = 0
        return None
# end-of-class(flist_nil)

class flist_cons(flist):
    def __init__(self, cons1, cons2):
        self.ctag = 1
        self.cons1 = cons1
        self.cons2 = cons2
        return None
    def get_cons1(self):
        return self.cons1
    def get_cons2(self):
        return self.cons2
# end-of-class(flist_cons)

def flist_foreach(xs, work_func):
    while(xs.ctag > 0):
        x0 = xs.cons1
        xs = xs.cons2
        work_func(x0)
    return None

def flist_listize(xs):
    return foreach_to_listize(flist_foreach)(xs)
def flist_foldleft(xs, r0, fopr_func):
    return foreach_to_foldleft(flist_foreach)(xs, r0, fopr_func)

####################################################

def forall_to_foreach(forall):
    def foreach(xs, work_func):
        def test_func(x0):
            work_func(x0)
            return True
        forall(xs, test_func)
        return None
    return foreach # forall-function is turned into foreach-function

#########################################################################

def foreach_to_forall(foreach):
    class FalseExn(Exception):
        def __init_(self):
            return None
    def forall(xs, test_func):
        def work_func(x0):
            if test_func(x0):
                return None
            else:
                raise FalseExn
        try:
            foreach(xs, work_func)
            return True
        except FalseExn:
            return False
    return forall # foreach-function is turned into forall-function

#########################################################################

def foreach_to_foldleft(foreach):
    def foldleft(xs, r0, fopr_func):
        res = r0
        def work_func(x0):
            nonlocal res
            res = fopr_func(res, x0)
            return None
        foreach(xs, work_func)
        return res
    return foldleft # foreach-function is turned into foldleft-function

def rforeach_to_foldright(rforeach):
    def foldright(xs, r0, fopr_func):
        res = r0
        def work_func(x0):
            nonlocal res
            res = fopr_func(x0, res)
            return None
        rforeach(xs, work_func)
        return res
    return foldright # foreach-function is turned into foldleft-function

#########################################################################

def foreach_to_listize(foreach):
    def listize(xs):
        res = []
        def work_func(x0):
            nonlocal res
            res.append(x0)
            return None
        foreach(xs, work_func)
        return res
    return listize # foreach-function is turned into listize-function

def foreach_to_rlistize(foreach):
    def rlistize(xs):
        res = []
        def work_func(x0):
            nonlocal res
            res.insert(0, x0)
            return None
        foreach(xs, work_func)
        return res
    return rlistize # foreach-function is turned into rlistize-function

#########################################################################

def foreach_to_rflistize(foreach):
    def rflistize(xs):
        res = flist_nil()
        def work_func(x0):
            nonlocal res
            res = flist_cons(x0, res)
            return None
        foreach(xs, work_func)
        return res
    return rflistize # foreach-function is turned into rflistize-function

#########################################################################

######################## end of [mypylib-cls.py] ########################
