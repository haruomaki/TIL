import sympy as sp

N = 6  # 何次までやるか
mu = sp.symbols("mu0:%d" % (N + 1))
# kappa = sp.symbols("kappa0:%d" % (N + 1))

kappa_expr = [None] * (N + 1)
kappa_expr[0] = 0
kappa_expr[1] = mu[1]

for n in range(1, N):
    s = 0
    for k in range(n):
        s += sp.binomial(n, k) * kappa_expr[k + 1] * mu[n - k]
    kappa_expr[n + 1] = sp.expand(mu[n + 1] - s)


# LaTeX出力
print("\\begin{aligned}")
for i in range(0, N + 1):
    print(f"  \\kappa_{i} &=", sp.latex(kappa_expr[i]), "\\\\")
print("\\end{aligned}")
