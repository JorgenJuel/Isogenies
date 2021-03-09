
#     \begin{tikzpicture}
#         \tikzstyle{level 1}=[level distance=12mm, sibling angle=120]
#         \tikzstyle{level 2}=[level distance=10mm, sibling angle=60]
#         \tikzstyle{level 3}=[level distance=10mm, sibling angle=30]
#         \tikzstyle{node}=[fill=COLOR1]
        
#         \node {root}
#         [grow cyclic]
#             child { 
#                 node {$30$} 
#                 child {
#                     node {$20$}
#                 }
#             }
#             child { 
#                 node {$30$} 
#             };
#     \end{tikzpicture}
# # 
# 
f = open("supersingular_graph.tikz", "w")
print("Starting to graph!")
f.write("\\begin{figure}[ht]\n")
f.write("\t\\centering\n")
f.write("\t\\begin{tikzpicture}\n")
f.write("\t\t\\tikzstyle{level 1}=[level distance=40mm, sibling angle=90]\n")
f.write("\t\t\\tikzstyle{level 2}=[level distance=19mm, sibling angle=45]\n")
f.write("\t\t\\tikzstyle{level 3}=[level distance=12mm, sibling angle=120]\n")
f.write("\t\t\\tikzstyle{jinvariant Node}=[draw, circle, text=white, fill=COLOR1,inner sep=0pt, minimum width=13mm]\n")

maxLevel = 2

def printChildren(level, start):
	if level > maxLevel:
		return

	isogenies = start.isogenies_prime_degree(degree)
	added = []
	for isogeny in isogenies:
		j = isogeny.codomain().j_invariant()
		if j not in added or level > 1:
			added.append(j)
			f.write("\n")
			f.write("\t" * (level + 2))
			f.write("child { node [jinvariant Node] {$\\begin{array}{c}")

			f.write("{}".format(j).replace('*z2', '\\omega').replace("+", "\\\\+"))
			f.write("\\end{array}$}")
			printChildren(level + 1, isogeny.codomain())
			f.write("\n")
			f.write("\t" * (level + 2))
			f.write("}")

p = 439
#p=431
#p = 31
field = GF(p*p) # Field of p^2 elements
E = EllipticCurve(field, [1,0])
#isogenies = E.isogenies_prime_degree(5)
expandables = [E]
degree = 5

f.write("\t\t\\node [jinvariant Node] {$")
f.write("{}".format(E.j_invariant()))
f.write("$} \n")
f.write("\t\t[grow cyclic] \n")
printChildren(1, E)
f.write(";\n")
f.write("\t\\end{tikzpicture}\n")

f.write("\t\\caption{Graph of supersingular j-invariants, starting at ")
f.write("{}".format(E.j_invariant()))
f.write(" with degree {} isogenies".format(degree))
f.write("}\n")
f.write("\t\\label{fig: supersingular j-invariants}\n")
f.write("\\end{figure}")
f.close()
#iso0 = isogenies[0]
#iso1 = isogenies[1].dual()
#comp = iso0 * iso1
#print(comp)
#
#
#