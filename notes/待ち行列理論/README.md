# 待ち行列理論

応用情報技術者試験に出題される待ち行列理論を、公式の導出も含めてまとめる。

## ポアソン過程

微小時間 $\Delta t = 1/n$ ごとに、確率 $p = λ/n$ で「起こるか起こらないか」を判定する**ベルヌーイ試行を無数に繰り返す**。

### 発生回数の分布

単位時間の間に何回イベントが生起するか（$k$ 回起きる確率）を考える。

```math
\begin{aligned}
P(X=k) &= \binom{n}{k} p^k (1-p)^{n-k} \\
\end{aligned}
```

ここから式変形を進めることもできるが（[参考](ポアソン分布.md#確率質量関数)）、今回は特性関数を利用してみる。

ベルヌーイ試行の連続であることを利用する。

```math
X =Y_1 + Y_2 + \cdots + Y_n
```

```math
\begin{aligned}
φ_Y(t) = 𝔼[e^{itY}] &= e^{it \cdot 1} p + e^{it \cdot 0} (1-p) \\
                    &= 1 - p + pe^{it}
\end{aligned}
```

独立な確率変数の和であるから、特性関数は個々の積になる。

```math
\begin{aligned}
φ_X(t) &= \prod_i φ_{Y_i}(t) \\
       &= (1 - p + pe^{it})^n \\
       &= \left( 1 + p(e^{it} - 1) \right)^n \\
       &= \left( 1 + \frac{λ(e^{it} - 1)}{n} \right)^n \\
       &\xrightarrow{n→∞} e^{λ(e^{it} - 1)} \\
\end{aligned}
```

$n→∞$ のときに続けて計算していくと、$e^x$ のマクローリン展開を用いて

```math
\begin{aligned}
φ_X(t) &= e^{-λ} \cdot e^{λe^{it}} \\
       &= e^{-λ} \cdot \sum_{m=0}^∞ \frac{(λe^{it})^m}{m!} \\
       &= e^{-λ} \cdot \sum_{m=0}^∞ \frac{λ^m}{m!} e^{itm} \\
       &= \sum_{m=0}^∞ e^{itm} \left( e^{-λ} \frac{λ^m}{m!} \right) \\
\end{aligned}
```

離散分布の特性関数の一般形と比較することで

```math
φ_X(t) = 𝔼[e^{itX}] = \sum_{k=0}^∞ e^{itk} P(X=k)
```

```math
\begin{equation}
\therefore P(X=k) = e^{-λ} \frac{λ^k}{k!}
\end{equation}
```

が得られる。

### 発生間隔の分布

前回のイベントからちょうど時間tが経過して次のイベントが発生する確率を考える。

```math
\begin{aligned}
I(t) &= (1-p)^{t/Δt} p \\
     &= \left( 1-\frac{λ}{n} \right)^{tn} \frac{λ}{n} \\
\end{aligned}
```

確率は0に収束するため、代わりに密度を考える。（確率＝短冊の面積、密度＝短冊の高さ）

```math
\begin{aligned}
f_T(t) &= \lim_{n→∞} \frac{I(t)}{Δt} \\
       &= \lim_{n→∞} \left( 1-\frac{λ}{n} \right)^{tn} λ \\
       &= λe^{-λt}
\end{aligned}
```

## $M/M/1$ 待ち行列モデル

待ち行列で何を状態にするか。

- 客一人ひとりの到着時刻
- どれくらい待ってるか
- サービス残り時間

などを考えたくなるが、指数分布の無記憶性より**「今この瞬間、サービスが終わる確率」はどれだけ処理が進んでいても同じ**。

必要な状態は「系内にいる客の人数」だけでいい。

### 到着 (birth)

到着間隔は指数分布（ハザード $λ$）。

### サービス完了 (death)

サービス時間も指数分布（ハザード $μ$）。窓口は1つ。

```text
n ──λ──▶ n+1
n ◀──μ── n+1   (n≥1)
```
