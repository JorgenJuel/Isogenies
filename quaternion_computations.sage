
p = 439
#p=431
#p = 31
field = GF(p**2) # Field of p^2 elements
w = field.gen()
sqrt = 180*w + 169
E = EllipticCurve(field, [1,0])

Pr.<x,y,z> = ProjectiveSpace(field, 2)
# Frobenius
pi = Pr.hom([x^p, y^p, z^p], Pr)
# Iota
iota = Pr.hom([-x, sqrt * y, z], Pr)

#pts = E.rational_points()

isogeny_ker_gen = E((125, 82, 1))
isogeny_degree = 5

kernel_set = [isogeny_ker_gen, 2* isogeny_ker_gen, 3* isogeny_ker_gen, 4*isogeny_ker_gen, 5*isogeny_ker_gen]

## Initialize quaterion algebra ramified at p and infty
Q.<i,j,k> = QuaternionAlgebra(QQ, -1, -p)
b1 = Q.basis()[0] # Trick to get 1 in Quaternion algebra 
b2 = i # Equivalent of iota
b3 = (1 + k)/2 # Equivalent of iota * pi
b4 = (i + j)/2 # Equivalent of iota + pi
#O0 = Q.ideal([b1, b2, b3, b4])
O0 = Q.maximal_order() # Default maximal order corresponds to this value

I = Q.ideal([1/2 + 2*j + 5/2*k, 1/2*i + 5/2*j + 2*k, 5*j, 5*k])

print(I)
print(I.right_order())
print(I.left_order())