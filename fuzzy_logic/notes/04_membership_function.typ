#set list(marker: ("#", "%", "-"))
#set page(number-align: right, numbering: "1")

#align(center, [
  = Membership Function
])

#v(2em)

== Features

- Core
  $ "core"_A = {x in X | mu_A (x) = 1} $

- Support
  $ "supp"_A = {x in X | mu_A (x) > 0} $

- Boundary
  $ "bound"_A = {x in X | 0 < mu_A (x) < 1} $

#v(1em)

== Types of fuzzy sets

- *Normal fuzzy set*\
  Fuzzy set $A$ with universe of discouse $X$ is a normal fuzzy set if for at least one value $x in X$, $mu_A (x) = 1$.

- *Subnormal fuzzy set*\
  Fuzzy set $A$ is subnormal if it is not normal, i.e. it does not have any value $x$ with membership value 1.

#figure(caption: [Normal and subnormal fuzzy membership], image("assets/normal.png", height: 8em))

- *Convex fuzzy set*\
  Fuzzy set $A$ with universe of discourse $X$ is a convex fuzzy set if its membership value is either monotonically increasing or monotonically decreasing with increasing values of $x$, i.e. if there are three values $x < y < z$, then both $x$ and $z$ cannot have a membership value greater than that of $y$ at the same time.
  $ mu_A (y) >= "min"(mu_A (x), mu_B (z)) $

- *Concave fuzzy set*\
  Fuzzy set $A$ is concave if it is not convex.

#figure(caption: [Convex and concave fuzzy membership], image("assets/convex.png", height: 8em))
