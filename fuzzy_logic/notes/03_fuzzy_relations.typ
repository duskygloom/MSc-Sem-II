#set list(marker: ("#", "%", "-"))
#set page(number-align: right, numbering: "1")

#align(center, [
  = Fuzzy Relations
])

#v(2em)

== Crisp relations

- A crisp relation $R(A, B)$ between two sets $A$ and $B$ is a subset of its cartesian product, $A times B$.
- We assign a strength, $chi(a, b)$, to each ordered pair $(a, b) in A times B$ such that:
  $
    chi(a, b) & = 1 #h(4em) &     "if" (a, b) in R \
    chi(a, b) & = 0 #h(4em) & "if" (a, b) in.not R
  $
- Note that this is a binary relation. For a general n-ary relation $R_n (X_1, X_2, ..., X_n)$, the cartesian product would be all possible n-tuples $(x_1, x_2, ..., x_n)$ such that $x_i in X_i$.

#v(1em)

== Fuzzy relations

- A fuzzy relation $R(A, B)$ of two fuzzy sets $A$ and $B$ with universe of discourse $X$ and $Y$ respectively is an ordered pair $((x, y), mu_((x, y)))$ such that $(x, y) in X times Y$, and $mu_((x, y)) in [0, 1]$.

#v(1em)

== Fuzzy cartesian product

- The cartesian product of two fuzzy sets $A$ and $B$ with universe of discourse $X$ and $Y$ respectively, $A times B$, is:
  $
    A times B & = sum_((x, y) in X times Y) ("min"(mu_A (x), mu_B (y))) / ((x, y)) \
              & = sum_((x, y) in X times Y) (mu_A (x) and mu_B (y)) / ((x, y))
  $

#v(1em)

== Domain and range

- The _domain_ of a fuzzy relation $R(A, B)$ defined on fuzzy sets $A$ and $B$ with universe of discourse $X$ and $Y$ respectively, $"dom" R$, is each element in set $X$ with membership values equal to the maximum strength with any element in $Y$.
  $ "dom" R = sum_(x in X) ("max"_(y in Y) space mu_R (x, y)) / x $
- The _range_ of a fuzzy relation $R(A, B)$ defined on fuzzy sets $A$ and $B$ with universe of discourse $X$ and $Y$ respectively, $"ran" R$, is each element in set $Y$ with membership values equal to the maximum strength with any element in $X$.
  $ "ran" R = sum_(y in Y) ("max"_(x in X) space mu_R (x, y)) / y $

- The _height_ of a fuzzy relation $R(A, B)$ defined on fuzzy sets $A$ and $B$ with universe of discourse $X$ and $Y$ respectively, $"height" R$, is the maximum strength of any $x in X$ with any $y in Y$.
  $ h(R) = "max"_(x in X) space "max"_(y in Y) space mu_R (x, y) $

- The _inverse_ of a fuzzy relation $R(A, B)$ defined on fuzzy sets $A$ and $B$ with universe of discourse $X$ and $Y$ respectively is a $Y times X$ relation, $R^(-1)(y, x) = R(x, y)$.

#v(1em)

== Composition

- If $R(A, B)$ and $S(B, C)$ are two fuzzy relations defined on fuzzy sets $A$, $B$ and $C$ with universe of discource $X$, $Y$ and $Z$ respectively, then composition of $R$ and $S$ defines the relation between $A$ and $C$, i.e. $R circle S = T(A, C)$.

=== Max-min composition
$
  T(x, z) = R circle S & = "max"_(y in Y) "min"(mu_R (x, y), mu_S (y, z)) \
                       & = or_(y in Y) mu_R (x, y) and mu_S (y, z)
$

=== Max-dot composition
$
  T(x, z) = R circle S & = "max"_(y in Y) space mu_R (x, y) dot mu_S (y, z) \
                       & = or_(y in Y) mu_R (x, y) dot mu_S (y, z) \
$

=== Example
#grid(
  columns: (1fr,) * 3,
  row-gutter: 1em,
  $ X = {x_1, x_2} $, $ Y = {y_1, y_2} $, $ Z = {z_1, z_2, z_3} $,
  $
    R = mat(
      delim: "[",
      0.7, 0.5;
      0.8, 0.4;
    )
  $,

  $
    S = mat(
      delim: "[",
      0.9, 0.6, 0.2;
      0.1, 0.7, 0.5;
    )
  $,
)

#v(1em)

#grid(
  columns: (1fr,) * 2,
  row-gutter: 1em,
  align: center,
  $
    R circle S = T(x, z) = mat(
      delim: "[",
      0.7, 0.6, 0.5;
      0.8, 0.6, 0.4;
    )
  $,
  $
    R circle S = T(x, z) = mat(
      delim: "[",
      0.63, 0.42, 0.25;
      0.72, 0.48, 0.20;
    )
  $,

  [Max-min composition], [Max-dot composition],
)

#v(1em)

== Fuzzy equivalence and tolerance

- A fuzzy relation $R(A)$, where $X$ is the universe of discourse of fuzzy set $A$, is equivalent if it is:
  #grid(
    columns: (8em, auto),
    row-gutter: 0.6em,
    [*Reflexive*], $ mu_R (x_i, x_i) = 1 $,
    [*Symmetric*], $ mu_R (x_i, x_j) = mu_R (x_j, x_i) $,
    [*Transitive*], $ mu_R (x_i, x_k) >= mu_R (x_i, x_j) and mu_R (x_j, x_k) $,
  )
- A fuzzy relation $R(A)$ is tolerant if it is reflexive and symmetric, but not necessarily transitive.
