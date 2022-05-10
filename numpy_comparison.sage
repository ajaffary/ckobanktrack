import numpy as np

x1 = cos(1).n()
x2 = np.cos(1)

y1 = sin(1).n()
y2 = np.sin(1)

L = [x1,x2]

show(L)

M = [x1**2, x2**2]

show(M)

N = [x1**(1/3), x2**(1/3)]

show(N)

P = [x1**(5/3), x2**(5/3)]

show(P)

Q = [y1**(5/3), y2**(5/3)]

show(Q)

r1 = sqrt(P[0]+Q[0])
r2 = sqrt(P[1]+Q[1])

R = [r1, r2]

show(R)

real_nth_root(x2.item(0),3)