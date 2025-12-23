import sympy as sp

N = 9  # 何次までやるか
mu = sp.symbols("mu0:%d" % (N + 1))
kappa = sp.symbols("kappa0:%d" % (N + 1))

kappa_expr = [None] * (N + 1)
kappa_expr[0] = 0
kappa_expr[1] = mu[1]

for n in range(1, N):
    s = 0
    for k in range(n):
        s += sp.binomial(n, k) * kappa_expr[k + 1] * mu[n - k]
    kappa_expr[n + 1] = sp.expand(mu[n + 1] - s)


# LaTeX出力
sp.init_printing(order="rev-lex")
print("\\begin{aligned}")
for i in range(1, N + 1):
    expr = kappa_expr[i].subs(mu[1], 0)
    print(f"  {sp.latex(kappa[i])} &= {sp.latex(expr)} \\\\")
print("\\end{aligned}")
