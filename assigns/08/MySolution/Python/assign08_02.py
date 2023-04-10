####################################################
#!/usr/bin/env python3
####################################################
"""
HX-2023-04-07: 20 points
You are required to implement the following function
generator_merge2 WITHOUT using streams. A solution that
uses streams is disqualified.
"""
def add_front(x, gen):
    yield x
    yield from gen

def generator_merge2(gen1, gen2, lte3):
    """
    Given two generators gen1 and gen2 and a comparison
    function lte3, the function generator_merge2 returns
    another generator that merges the elements produced by
    gen1 and gen2 according to the order specified by lte3.
    The function generator_merge2 is expected to work correctly
    for both finite and infinite generators.
    """
    while True:
        try:
            x1 = next(gen1)
            try:
                x2 = next(gen2)
                if lte3(x1,x2):
                    yield x1
                    gen2 = add_front(x2,gen2)
                else:
                    yield x2
                    gen1 = add_front(x1,gen1)
            except StopIteration:
                yield x1
                yield from gen1
                break
        except StopIteration:
            yield from gen2
            break

    return StopIteration
####################################################
